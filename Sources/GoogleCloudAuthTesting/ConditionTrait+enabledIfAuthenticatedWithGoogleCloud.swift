import Foundation
import Testing

extension Trait where Self == Testing.ConditionTrait {

  public static var enabledIfAuthenticatedWithGoogleCloud: Self {
    .enabled(if: isGoogleApplicationCredentialsSet || hasGoogleApplicationCredentials)
  }

  private static var isGoogleApplicationCredentialsSet: Bool {
    ProcessInfo.processInfo.environment["GOOGLE_APPLICATION_CREDENTIALS"] != nil
  }

  private static var hasGoogleApplicationCredentials: Bool {
    guard let home = ProcessInfo.processInfo.environment["HOME"] else {
      return false
    }
    let credentialsPath = home + "/.config/gcloud/application_default_credentials.json"
    guard let data = try? Data(contentsOf: URL(fileURLWithPath: credentialsPath)) else {
      return false
    }
    return !data.isEmpty
  }
}
