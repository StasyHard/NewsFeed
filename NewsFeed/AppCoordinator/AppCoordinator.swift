
import UIKit


final class AppCoordinator: BaseCoordirator {
    
    // MARK: - Properties
       private let window: UIWindow
       private let navController: UINavigationController
    
    
    // MARK: - Init
     init(window: UIWindow, navController: UINavigationController) {
        self.window = window
        self.navController = navController
    }
    
    
    //MARK: - Open metods
    override func start() {
        window.rootViewController = navController
        window.makeKeyAndVisible()
        parentCoordinator = nil
        showNewsFeed()
    }
    
    private func showNewsFeed() {
        let newsFeedCoordinator = NewsFeedCoordinator(navController: navController)
        newsFeedCoordinator.start()
    }
}
