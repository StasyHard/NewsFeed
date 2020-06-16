
import UIKit

protocol TableViewProvider: UITableViewDelegate, UITableViewDataSource { }


final class NewsFeedTableViewProvider: NSObject, TableViewProvider {
    
    //MARK: - Open properties
    var tableViewState: TableViewState?
    
    
    //MARK: - TableViewProvider metods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let state = tableViewState
            else { return 0 }
        
        switch state {
        case .failed(state: _), .loading:
            tableView.setEmptyView(forState: state)
            return 0
        case .success(value: let news):
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
                print(newsItem.title)
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
}
