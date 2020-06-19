
import UIKit


final class DetailsNewsCoordinator: BaseCoordirator {
    
    //MARK: - Private properties
    private let navController: UINavigationController
    private let news: NewsItem
   
    
    //MARK: - Init
    init(navController: UINavigationController, news: NewsItem) {
        self.navController = navController
        self.news = news
    }
    
    
      //MARK: - Open metods
    override func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(
            withIdentifier: "DetailsNewsViewController") as! DetailsNewsViewController
        let presenter = DetailsNewsPresenter(view: vc, news: news)
        vc.actionDelegate = presenter
        
        navController.pushViewController(vc, animated: true)
    }
    
}
