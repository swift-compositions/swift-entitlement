import Testing

@testable import Entitlement

extension Entitlement {
    @Suite
    struct Test {
        @Test
        func `grant retains its source`() {
            let policy: Entitlement.Policy<String, Int, String> = .init(rules: [
                .init(
                    capability: "reports",
                    effect: .grant,
                    expiration: nil,
                    priority: .base,
                    source: "plan"
                )
            ])

            let decision = policy.decision(for: "reports", at: 0)

            #expect(decision.effect == .grant)
            #expect(decision.reason == .rule)
            #expect(decision.source == "plan")
        }

        @Test
        func `deny wins an equal priority conflict`() {
            let policy: Entitlement.Policy<String, Int, String> = .init(rules: [
                .init(
                    capability: "reports",
                    effect: .grant,
                    expiration: nil,
                    priority: .base,
                    source: "plan"
                ),
                .init(
                    capability: "reports",
                    effect: .deny,
                    expiration: nil,
                    priority: .base,
                    source: "restriction"
                ),
            ])

            let decision = policy.decision(for: "reports", at: 0)

            #expect(decision.effect == .deny)
            #expect(decision.reason == .rule)
            #expect(decision.source == "restriction")
        }

        @Test
        func `absence denies by default`() {
            let policy: Entitlement.Policy<String, Int, String> = .init(rules: [])

            let decision = policy.decision(for: "reports", at: 0)

            #expect(decision.effect == .deny)
            #expect(decision.reason == .absent)
            #expect(decision.source == nil)
        }

        @Test
        func `expiration excludes its boundary`() {
            let policy: Entitlement.Policy<String, Int, String> = .init(rules: [
                .init(
                    capability: "reports",
                    effect: .grant,
                    expiration: 10,
                    priority: .base,
                    source: "trial"
                )
            ])

            #expect(policy.decision(for: "reports", at: 9).effect == .grant)

            let decision = policy.decision(for: "reports", at: 10)

            #expect(decision.effect == .deny)
            #expect(decision.reason == .expired)
            #expect(decision.source == "trial")
        }

        @Test
        func `override grant outranks base deny`() {
            let policy: Entitlement.Policy<String, Int, String> = .init(rules: [
                .init(
                    capability: "reports",
                    effect: .deny,
                    expiration: nil,
                    priority: .base,
                    source: "plan"
                ),
                .init(
                    capability: "reports",
                    effect: .grant,
                    expiration: nil,
                    priority: .override,
                    source: "administrator"
                ),
            ])

            let decision = policy.decision(for: "reports", at: 0)

            #expect(decision.effect == .grant)
            #expect(decision.reason == .rule)
            #expect(decision.source == "administrator")
        }

        @Test
        func `caller supplied capability types remain generic`() {
            let policy: Entitlement.Policy<Int, Int, String> = .init(rules: [
                .init(
                    capability: 42,
                    effect: .grant,
                    expiration: nil,
                    priority: .base,
                    source: "numeric"
                )
            ])

            #expect(policy.decision(for: 42, at: 0).effect == .grant)
            #expect(policy.decision(for: 7, at: 0).effect == .deny)
        }
    }
}
