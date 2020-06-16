
import UIKit


final class NewsFeedViewController: UIViewController {
    
    //MARK: - Open properties
    var actionDelegate: NewsFeedViewActions?
    
    
    //MARK: - Private properties
   private lazy var newsFeedView = view as? NewsFeedView
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        actionDelegate?.viewDidLoad()
    }
    
    
    //MARK: - Private metods
    private func setupNavigation() {
        self.title = "Новости"
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.largeTitleTextAttributes =
//            [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)]
    }
    
}


extension NewsFeedViewController: NewsFeedViewEmplementation {
    
    func showContent(forState state: TableViewState) {
        newsFeedView?.setNewsFeedTableViewState(state)
    }
    
    
}
