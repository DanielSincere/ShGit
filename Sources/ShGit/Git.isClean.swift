import Sh
import Foundation

extension Git {
  /// Return `true` if the git repo is clean, `false` if not
  /// Throws a `notGitRepository` error if the path is not within a git repo
  ///
  public func isClean() throws -> Bool {

    let cmd = "git status --porcelain"

    let allOutput = try Process(cmd: cmd, workingDirectory: workingDirectory).runReturningAllOutput()
    let stdOut = allOutput.stdOut?.asTrimmedString(encoding: .utf8)
    let stdErr = allOutput.stdErr?.asTrimmedString(encoding: .utf8)

    if let stdErr = stdErr {
      throw Errors.interpretError(message: stdErr)
    } else {
      if let stdOut = stdOut, !stdOut.isEmpty {
        return false
      } else {
        return true
      }
    }
  }
}
