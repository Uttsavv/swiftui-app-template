# SwiftUI app template

A starting point for iOS 26+ SwiftUI apps: Swift 6 concurrency, a small design system with Liquid Glass and concentric corners, accessibility checks built in, and rules plus skills that keep Claude on current APIs.

## Start a new app
1. On GitHub, click **Use this template** to create the new repo, then clone it.
2. `scripts/new-app.sh MyApp com.yourname` renames the app and bundle ID.
3. `scripts/bootstrap.sh` installs XcodeGen if needed and generates `MyApp.xcodeproj`.
4. Open Claude in the repo. On the first session it asks about colour scheme, motion and type, then records the answers in `docs/design-brief.md`.

## What's inside
| Path | Purpose |
| --- | --- |
| `App/` | App target: `TabView` shell with Home, Settings and a search tab, `@Observable` app model |
| `Packages/DesignSystem/` | Theme, colour tokens (light, dark, Increase Contrast), type, spacing, radii, motion, glass and concentric helpers, components, catalog screen |
| `App/UITests/` | Xcode accessibility audits per screen, including the largest text size |
| `Packages/DesignSystem/Tests/` | Contrast tests for every colour pairing, motion tests |
| `CLAUDE.md` | Rules Claude follows in every app made from this template |
| `.claude/skills/` | Vendored MIT agent skills for SwiftUI, SwiftData, concurrency, Liquid Glass, background work |
| `docs/design-brief.md` | Per-app colour, motion and type decisions |

## Requirements
Xcode 26 or later (Xcode 27 recommended), iOS 26 deployment target, [XcodeGen](https://github.com/yonaskolb/XcodeGen).
