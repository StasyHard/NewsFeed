
import UIKit


protocol NewsFeedTableViewProviderImpl {
    var tableViewState: TableViewState? { get set }
    var actionDelegate: NewsFeedViewActions? { get set }
}


final class NewsFeedTableViewProvider: NSObject, NewsFeedTableViewProviderImpl {
    
    //MARK: - Open properties
    var tableViewState: TableViewState?
    var actionDelegate: NewsFeedViewActions?
    
}



//MARK: - UITableViewDelegate and UITableViewDataSourse
extension NewsFeedTableViewProvider: TableViewProvider {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let state = tableViewState
            else { return 0 }
        
        switch state {
        case .failed(state: _), .loading:
            tableView.setEmptyView(forState: state)
            return 0
        case .success(value: let news):
            tableView.removeEmptyView()
            return news.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let state = tableViewState
            else { return UITableViewCell() }
        
        switch state {
        case .success(value: let news):
            if let cell = tableView
                .dequeueReusableCell(withIdentifier: NewsFeedCell.reuseId,
                                     for: indexPath) as? NewsFeedCell
            {
                let newsItem = news[indexPath.row]
                cell.titleNewsLabel.text = newsItem.title
                cell.categoryLabel.text = newsItem.category
                cell.pubDateLabel.text = newsItem.pubDate
                
                return cell
            }
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let state = tableViewState
            else { return }
        
        switch state {
        case .success(value: let news):
            let newsItem = news[indexPath.row]
            actionDelegate?.wasSelectedNews(news: newsItem)
        default: break
        }
    }
}
