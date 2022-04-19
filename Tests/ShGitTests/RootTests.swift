@testable import ShGit
import Sh
import XCTest

final class RootTests: XCTestCase {

  lazy var testDir = "/tmp/ShGit/root-tests"

  func testInGitRoot() {
    let git = Git(workingDirectory: testDir)

#if os(Linux)
    XCTAssertEqual(try git.root(), testDir)
#else
    XCTAssertEqual(try git.root(), "/private" + testDir)
#endif
  }

  func testInSubfolders() {
    let git = Git(workingDirectory: testDir + "/some/some/folders")
#if os(Linux)
    XCTAssertEqual(try git.root(), testDir)
#else
    XCTAssertEqual(try git.root(), "/private" + testDir)
#endif
  }

  func testThrowErrorWhenNotInGitRepo() {
    let git = Git(workingDirectory: "/tmp")

    XCTAssertThrowsError(try git.root(), "expected an error") { error in
      if let e = error as? Git.Errors {
        XCTAssertEqual(e, Git.Errors.notGitRepository)
      } else {
        XCTFail("unexpected error: \(error)")
      }
    }
  }

  override func setUpWithError() throws {
    try super.setUpWithError()

    try FileManager.default.createDirectory(at: URL(fileURLWithPath: testDir + "/some/some/folders"), withIntermediateDirectories: true)
    try sh(.terminal, "git init -b main", workingDirectory: testDir)
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()

    try FileManager.default.removeItem(at: URL(fileURLWithPath: testDir))
  }
}
