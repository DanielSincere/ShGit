import Sh
import Foundation

extension Git {
  /// Returns the path to the root of the Git repo
  /// Throws a `notGitRepository` error if the path is not within a git repo
  public func root() throws -> String {
    let cmd = "git rev-parse --show-toplevel"

    let allOutput = try Process(cmd: cmd, workingDirectory: workingDirectory).runReturningAllOutput()
    let stdOut = allOutput.stdOut.asTrimmedString(encoding: .utf8)
    let stdErr = allOutput.stdErr.asTrimmedString(encoding: .utf8)

    if let stdErr = stdErr {
      throw Errors.interpretError(message: stdErr)
    } else if let stdOut = stdOut {
      return stdOut
    } else {
      throw Errors.unknownError
    }
  }
}
