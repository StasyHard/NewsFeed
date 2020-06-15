
import Foundation


protocol NewsFeedViewEmplementation: class {
    
}

protocol NewsFeedViewActions: class {
    
}

final class NewsFeedPresenter {
    
        //MARK: - Private properties
    private var view: NewsFeedViewEmplementation?
    private let newsFeedRepo: NewsFeedRepoImplementation
    
    
    init(view: NewsFeedViewEmplementation, repo: NewsFeedRepoImplementation) {
        self.view = view
        self.newsFeedRepo = repo
    }
}



extension NewsFeedPresenter: NewsFeedViewActions {
    
}
