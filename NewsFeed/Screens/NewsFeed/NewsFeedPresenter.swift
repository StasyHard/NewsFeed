
import Foundation


protocol NewsFeedViewEmplementation: class {
    func showContent(forState state: TableViewState)
}

protocol NewsFeedViewActions: class {
    func viewDidLoad()
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
    
    func viewDidLoad() {
        newsFeedRepo.getNewsFeed { [weak self] result in
            
            guard let `self` = self
                else { return }
            
            switch result {
            case .success(let news):
                self.view?.showContent(forState: .success(value: news))
                break
            case .failure(let error):
                self.view?.showContent(forState: .failed(state: error))
            }
        }
    }
}
