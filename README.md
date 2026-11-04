# swift-entitlement

Use this package when you decide whether a user or account may use a feature, from rules that grant or deny it, can expire, and can be overridden, and you want to know which rule decided. Build an `Entitlement.Policy` from `Entitlement.Rule` values and ask it with `Entitlement.Policy.decision(for:at:)`. You supply the capability, time and source types.

## Laws

- Denial is the default. With no rule for the capability, the decision is deny with reason `Entitlement.Decision.Reason.absent` and no source.
- A rule has expired once the instant reaches its expiration. The boundary is excluded: a rule expiring at 10 applies at 9 and not at 10. A rule with no expiration never expires.
- Among rules that haven't expired, an override rule beats a base rule. At the same priority, deny beats grant. Between rules that tie on both, the one listed first wins.
- An expired rule never grants. If every matching rule has expired, the decision is deny with reason `Entitlement.Decision.Reason.expired`, and its source is the expired rule that would have won.
- Expired rules are ignored as soon as one live rule matches, whatever its priority.
- The decision carries the source of the winning rule, so you can tell a plan from an administrator's override.
