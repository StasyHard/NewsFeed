
import UIKit


final class NewsFeedView: UIView {
    
    //MARK: - IBOutlet
    @IBOutlet weak var newsFeedTableView: UITableView! {
        didSet{
            newsFeedTableView.tableFooterView = UIView()
        }
    }
    
    
    //MARK: - Private properties
    private lazy var contentTableViewProvider: NewsFeedTableViewProvider = {
        let provider = NewsFeedTableViewProvider()
        newsFeedTableView.delegate = provider
        newsFeedTableView.dataSource = provider
        return provider
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    //MARK: - Open metods
    func setNewsFeedTableViewState(_ state: TableViewState) {
        contentTableViewProvider.tableViewState = state
        newsFeedTableView.reloadData()
    }
    
    
    //MARK: - Private metods
    private func setupUI() {
    }
}
