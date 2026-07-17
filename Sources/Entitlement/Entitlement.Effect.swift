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
    /// The explicit effect of an entitlement rule.
    public enum Effect: Equatable, Sendable {
        /// Permit the capability.
        case grant

        /// Refuse the capability.
        case deny
    }
}
