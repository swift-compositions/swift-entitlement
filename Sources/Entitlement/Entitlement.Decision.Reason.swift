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

extension Entitlement.Decision {
    /// Why the decision was reached.
    public enum Reason: Equatable, Sendable {
        /// No rule described the capability.
        case absent

        /// Matching rules existed but had expired.
        case expired

        /// An applicable rule decided the capability.
        case rule
    }
}
