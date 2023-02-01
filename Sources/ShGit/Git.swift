import Sh
import Foundation

public final class Git {

  public let workingDirectory: String?
  public init(workingDirectory: String? = nil) {
    self.workingDirectory = workingDirectory
  }

  public enum Errors: Error, LocalizedError, Equatable {
    case notGitRepository
    case unknownError(String)
    
    public var errorDescription: String? {
      switch self {
      case .notGitRepository:
        return "Not a git repository"
      case .unknownError(let message):
        return "Unknown error: \(message)"
      }
    }
  
    static func interpretError(message: String) -> Self {
      switch message {
      case "fatal: not a git repository (or any of the parent directories): .git":
        return .notGitRepository
      default:
        return .unknownError(message)
      }
 
    }
  }
}
