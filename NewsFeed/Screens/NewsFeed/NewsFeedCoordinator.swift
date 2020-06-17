
import UIKit


protocol NewsFeedImpl {
    func filtersDidTapped()
}


final class NewsFeedCoordinator: BaseCoordirator {
    
    //MARK: - Private properties
    private let navController: UINavigationController
    private let newsFeedRepo: NewsFeedRepo
    
    
    //MARK: - Init
    init(navController: UINavigationController) {
        self.navController = navController
        self.newsFeedRepo = NewsFeedRepo()
    }
    
    
    //MARK: - Open metods
    override func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(
            withIdentifier: "NewsFeedViewController") as! NewsFeedViewController
        let presenter = NewsFeedPresenter(view: vc, repo: newsFeedRepo, coordinator: self)
        vc.actionDelegate = presenter
        
        navController.pushViewController(vc, animated: true)
    }
}


extension NewsFeedCoordinator: NewsFeedImpl {
    func filtersDidTapped() {
    }
    
    
}
