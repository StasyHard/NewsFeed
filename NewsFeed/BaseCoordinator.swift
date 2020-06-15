
import Foundation


class BaseCoordirator: Coordinator {
    
    weak var parentCoordinator: BaseCoordirator?
    var childCoordinators: [BaseCoordirator] = []
    
    func start() {
        print("Will be redefined in childrens")
    }
}
