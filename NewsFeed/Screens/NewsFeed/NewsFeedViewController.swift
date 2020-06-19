
import UIKit


final class NewsFeedViewController: UIViewController {
    
    //MARK: - Open properties
    var actionDelegate: NewsFeedViewActions?
    
    
    //MARK: - Private properties
    private lazy var newsFeedView = view as? NewsFeedView
    private var filtersView: FiltersView?
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        if let actionDelegate = actionDelegate {
            newsFeedView?.setActionDelegate(delegate: actionDelegate)
            actionDelegate.viewDidLoad()
        }
    }
    
    
    //MARK: - Private metods
    private func setupNavigation() {
        navigationItem.title = "Новости"
        
        let filterButtonImg = UIImage(named: "filter")?
            .scaleTo(CGSize(width: 25, height: 25))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: filterButtonImg,
            style: .plain,
            target: self,
            action: #selector(filterButtonTapped))
    }
    
    @objc private func filterButtonTapped() {
        actionDelegate?.filtersButtonTapped()
    }
}



//MARK: - NewsFeedViewEmplementation
extension NewsFeedViewController: NewsFeedViewControllerImpl {
    
    func hideFiltres() {
        filtersView?.hideFiltres()
    }
    
    func showFilters(selectedFilter filter: String?, filters: [String]) {
        filtersView = FiltersView(frame: self.view.frame, actionDelegate: actionDelegate)
        filtersView?.showFilters(selectedFilter: filter, filters: filters)
    }
    
    func showContent(forState state: TableViewState) {
        newsFeedView?.setNewsFeedTableViewState(state)
    }
}







