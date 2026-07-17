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
    /// A caller-owned capability rule.
    public struct Rule<Capability: Equatable, Instant: Comparable, Source> {
        /// The capability governed by the rule.
        public let capability: Capability

        /// The explicit grant or deny effect.
        public let effect: Effect

        /// The first instant at which the rule no longer applies.
        public let expiration: Instant?

        /// Whether the rule is base input or an explicit override.
        public let priority: Priority

        /// Caller-owned provenance retained in the decision.
        public let source: Source

        /// Creates a capability rule.
        public init(
            capability: Capability,
            effect: Effect,
            expiration: Instant?,
            priority: Priority,
            source: Source
        ) {
            self.capability = capability
            self.effect = effect
            self.expiration = expiration
            self.priority = priority
            self.source = source
        }
    }
}
