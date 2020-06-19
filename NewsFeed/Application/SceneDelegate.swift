
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var appCoordinator: AppCoordinator?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        
        window.windowScene = windowScene
        
        let navController = UINavigationController()
        let coordinator = AppCoordinator(window: window, navController: navController)
        
        appCoordinator = coordinator
        appCoordinator?.start()
    }
    
}

