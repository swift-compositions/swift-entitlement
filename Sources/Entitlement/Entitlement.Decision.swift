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
    /// The effect, reason, and source selected by a policy.
    public struct Decision<Source> {
        /// The selected grant or deny effect.
        public let effect: Effect

        /// Why the policy selected the effect.
        public let reason: Reason

        /// The source of the selected or expired rule.
        public let source: Source?
    }
}
