extension Entitlement {

    public struct Rule<Capability: Equatable, Instant: Comparable, Source> {

        public let capability: Capability

        public let effect: Effect

        public let expiration: Instant?

        public let priority: Priority

        public let source: Source

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
