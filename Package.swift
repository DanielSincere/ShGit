// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "ShGit",
  platforms: [
    .macOS(.v12),
  ],
  products: [
    .library(name: "ShGit", targets: ["ShGit"])
  ],
  dependencies: [
    .package(url: "https://github.com/FullQueueDeveloper/Sh.git", from: "1.0.0"),
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
