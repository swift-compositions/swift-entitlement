extension Entitlement {

    public struct Decision<Source> {

        public let effect: Effect

        public let reason: Reason

        public let source: Source?
    }
}
