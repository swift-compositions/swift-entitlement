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

extension Entitlement.Rule {
    /// The precedence class of a rule.
    public enum Priority: Equatable, Sendable {
        /// Normal policy input.
        case base

        /// An explicit rule that takes precedence over base input.
        case override
    }
}
