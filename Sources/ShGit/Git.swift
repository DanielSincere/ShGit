import Sh
import Foundation

public final class Git {

  public let workingDirectory: String?
  public init(workingDirectory: String? = nil) {
    self.workingDirectory = workingDirectory
  }

  public enum Errors: String, Error {
    case notGitRepository = "fatal: not a git repository (or any of the parent directories): .git"
    case unknownError

    static func interpretError(message: String) -> Self {
      if let e = Self.init(rawValue: message) {
        return e
      } else {
        return .unknownError
      }
    }
  }
}
