extension Entitlement.Decision {

    public enum Reason: Equatable, Sendable {

        case absent

        case expired

        case rule
    }
}
