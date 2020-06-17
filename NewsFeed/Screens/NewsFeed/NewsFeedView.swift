
import UIKit


final class NewsFeedView: UIView {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var newsFeedTableView: UITableView! {
        didSet{
            newsFeedTableView.tableFooterView = UIView()
            newsFeedTableView.backgroundColor = AppColors.backgroungColor
            newsFeedTableView.separatorStyle = .none
            registerCells()
        }
    }
    
    
    //MARK: - Private properties
    private var actionsDelegate: NewsFeedViewActions?
    private lazy var contentTableViewProvider: NewsFeedTableViewProvider = {
        let provider = NewsFeedTableViewProvider()
        newsFeedTableView.delegate = provider
        newsFeedTableView.dataSource = provider
        return provider
    }()
    
    
    //MARK: - Init
    init(frame: CGRect, actionsDelegate: NewsFeedViewActions) {
        self.actionsDelegate = actionsDelegate
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
    
    func setActionDelegate(delegate: NewsFeedViewActions) {
        self.actionsDelegate = delegate
        //contentTableViewProvider.setActionDelegate
    }
    
    
    //MARK: - Private metods
    private func setupUI() {
    }
    
    private func registerCells() {
        let nib = UINib(nibName: "NewsFeedCell", bundle: nil)
        newsFeedTableView
            .register(nib, forCellReuseIdentifier: NewsFeedCell.reuseId)
    }
}
