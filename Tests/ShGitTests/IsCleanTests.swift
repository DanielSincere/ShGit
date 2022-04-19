@testable import ShGit
import Sh
import XCTest

final class IsCleanTests: XCTestCase {

  lazy var testDir = "/tmp/test-git"
  lazy var testFile = "/tmp/test-git/greeting.txt"

  func testStatusOfEmptyGitRepo() throws {
    let git = Git(workingDirectory: testDir)
    XCTAssertTrue(try git.isClean())
  }

  func testStatusOfDirtyGitRepo() throws {
    let git = Git(workingDirectory: testDir)
    try "Hello world!".data(using: .utf8)?.write(to: URL(fileURLWithPath: testFile))
    XCTAssertFalse(try git.isClean())
  }

  func testStatusOfCleanGitRepo() throws {
    let git = Git(workingDirectory: testDir)
    try "Hello world!".data(using: .utf8)?.write(to: URL(fileURLWithPath: testFile))

    try sh(.terminal, #"git config user.email "you@example.com""#, workingDirectory: testDir)
    try sh(.terminal, #"git config --global user.name "Your Name""#, workingDirectory: testDir)
    try sh(.terminal, "git add greeting.txt", workingDirectory: testDir)
    try sh(.terminal, "git commit -m \"greeting\"", workingDirectory: testDir)
    XCTAssertTrue(try git.isClean())
  }

  func testThrowErrorWhenNotInGitRepo() throws {
    let git = Git(workingDirectory: "/tmp")
    XCTAssertThrowsError(try git.isClean(), "expected an error") { error in
      if let e = error as? Git.Errors {
        XCTAssertEqual(e, Git.Errors.notGitRepository)
      } else {
        XCTFail("unexpected error: \(error)")
      }
    }
  }

  override func setUpWithError() throws {
    try super.setUpWithError()

    try sh(.terminal, "mkdir -p \(testDir)")
    try sh(.terminal, "git init -b main", workingDirectory: testDir)

  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()

    try FileManager.default.removeItem(at: URL(fileURLWithPath: testDir))
  }
}
