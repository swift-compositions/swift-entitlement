// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-entitlement open source project
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp and the swift-entitlement
// project authors
// Licensed under Apache License v2.0
//
// See LICENSE.md for license information
//
// ===----------------------------------------------------------------------===//

extension Entitlement {
    /// A collection of entitlement rules resolved for one capability at a time.
    public struct Policy<Capability: Equatable, Instant: Comparable, Source> {
        private let rules: [Rule<Capability, Instant, Source>]

        /// Creates a policy from caller-owned rules.
        public init(rules: [Rule<Capability, Instant, Source>]) {
            self.rules = rules
        }
    }
}

extension Entitlement.Policy {
    /// Resolves a capability at the supplied instant.
    public func decision(
        for capability: Capability,
        at instant: Instant
    ) -> Entitlement.Decision<Source> {
        var selected: Entitlement.Rule<Capability, Instant, Source>?
        var expired: Entitlement.Rule<Capability, Instant, Source>?

        for rule in rules where rule.capability == capability {
            if let expiration = rule.expiration, expiration <= instant {
                expired = preferred(rule, over: expired)
            } else {
                selected = preferred(rule, over: selected)
            }
        }

        if let selected {
            return .init(
                effect: selected.effect,
                reason: .rule,
                source: selected.source
            )
        }

        if let expired {
            return .init(
                effect: .deny,
                reason: .expired,
                source: expired.source
            )
        }

        return .init(
            effect: .deny,
            reason: .absent,
            source: nil
        )
    }

    private func preferred(
        _ candidate: Entitlement.Rule<Capability, Instant, Source>,
        over current: Entitlement.Rule<Capability, Instant, Source>?
    ) -> Entitlement.Rule<Capability, Instant, Source> {
        guard let current else { return candidate }

        switch (candidate.priority, current.priority) {
        case (.override, .base):
            return candidate

        case (.base, .override):
            return current

        default:
            break
        }

        switch (candidate.effect, current.effect) {
        case (.deny, .grant):
            return candidate

        default:
            return current
        }
    }
}
