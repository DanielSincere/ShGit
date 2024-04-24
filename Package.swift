// swift-tools-version:5.9

import PackageDescription

let package = Package(
  name: "ShGit",
  platforms: [
    .macOS(.v13),
  ],
  products: [
    .library(name: "ShGit", targets: ["ShGit"])
  ],
  dependencies: [
    .package(url: "https://github.com/DanielSincere/Sh.git", from: "1.3.0"),
  ],
  targets: [
    .target(name: "ShGit", dependencies: [
      "Sh"
    ]),
    .testTarget(name: "ShGitTests", dependencies: [
      "ShGit", "Sh"
    ]),
  ]
)
