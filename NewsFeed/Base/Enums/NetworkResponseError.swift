
import Foundation


enum NetworkResponseError: Error {
    case errorTimedOut
    case notConnectedToInternet
    case anotherError
}
