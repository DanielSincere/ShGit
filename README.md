# ShGit

Git wrapper for Swift powered by [Sh](https://github.com/FullQueueDeveloper/Sh).

## Example

### Example usage

    import ShGit

    let git = Git()

    // check if repo is clean
    guard git.isClean() else {
      print("git repo is not clean")
      return
    }

    let root = try git.root() // Fetch the root of the git repo

    // ...
    // do something with the git root
    // such as load an asset or
    // run a script

### Example `Package.swift`

    // swift-tools-version:5.6

    import PackageDescription

    let package = Package(
        name: "Scripts",
        platforms: [.macOS(.v12)],
        dependencies: [
          .package(url: "https://github.com/FullQueueDeveloper/ShGit.git", from: "1.0.0"),
        ],
        targets: [
            .executableTarget(
                name: "MyScript",
                dependencies: ["ShGit"]
            ),
        ]
    )
