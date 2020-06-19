
import Foundation


enum TableViewState {
    case loading
    case failed(state: NetworkResponseError)
    case success(value: [NewsItem])
}
