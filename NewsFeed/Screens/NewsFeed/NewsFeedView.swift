
import UIKit


final class NewsFeedView: UIView {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var newsFeedTableView: UITableView! {
        didSet{
            newsFeedTableView.tableFooterView = UIView()
            newsFeedTableView.backgroundColor = AppColors.backgroungColor
            newsFeedTableView.separatorStyle = .none
            newsFeedTableView.refreshControl = refreshControl
            registerCells()
        }
    }
    
    
    //MARK: - Private properties
    private var actionsDelegate: NewsFeedViewActions?
    private lazy var contentTableViewProvider: NewsFeedTableViewProviderImpl = {
        let provider = NewsFeedTableViewProvider()
        newsFeedTableView.delegate = provider
        newsFeedTableView.dataSource = provider
        return provider
    }()
    
    private let refreshControl: UIRefreshControl = {
       let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refresh
    }()
    
    
    //MARK: - Open metods
    func setNewsFeedTableViewState(_ state: TableViewState) {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
        contentTableViewProvider.tableViewState = state
        newsFeedTableView.reloadData()
    }
    
    func setActionDelegate(delegate: NewsFeedViewActions) {
        self.actionsDelegate = delegate
        contentTableViewProvider.actionDelegate = delegate
    }
    
    
    //MARK: - Private metods
    @objc func refresh(sender: UIRefreshControl) {
        actionsDelegate?.reloadData()
        //sender.endRefreshing()
    }
    
    private func registerCells() {
        let nib = UINib(nibName: "NewsFeedCell", bundle: nil)
        newsFeedTableView
            .register(nib, forCellReuseIdentifier: NewsFeedCell.reuseId)
    }
}
