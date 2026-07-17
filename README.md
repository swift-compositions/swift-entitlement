# swift-entitlement

![Development Status](https://img.shields.io/badge/status-active--development-orange.svg)

Grant and deny capability entitlements with expiry and explicit override precedence.

---

## Key Features

- **Default deny** — Capabilities without an applicable rule are denied.
- **Explicit outcomes** — Rules grant or deny a caller-supplied capability.
- **Expiry boundaries** — Callers supply their own comparable instant type.
- **Override precedence** — Override rules take precedence over base rules.
- **Decision context** — Results retain the winning reason and source.

---

## Installation

```swift
dependencies: [
    .package(
        url: "https://github.com/swift-foundations/swift-entitlement.git",
        branch: "main"
    )
]
```

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "Entitlement", package: "swift-entitlement")
    ]
)
```

---

## Quick Start

```swift
import Entitlement

let rules = [
    Entitlement.Rule(
        capability: "reports", effect: .grant, expiration: 10, priority: .base,
        source: "plan"
    ),
    Entitlement.Rule(
        capability: "reports", effect: .deny, expiration: nil, priority: .override,
        source: "administrator"
    ),
]

let policy = Entitlement.Policy(rules: rules)
let decision = policy.decision(for: "reports", at: 5)
print(decision.effect)
```

---

## License

Licensed under the [Apache License, Version 2.0](LICENSE.md).
