
import Foundation

protocol DetailsNewsViewEmpl: class {
    
}

protocol DetailsNewsViewActions: class {
    
}


final class DetailsNewsPresenter {
    
    //MARK: - Private properties
    private let view: DetailsNewsViewEmpl
    
    
    //MARK: - Init
    init(view: DetailsNewsViewEmpl) {
        self.view = view
    }
}



extension DetailsNewsPresenter: DetailsNewsViewActions {
    
}
