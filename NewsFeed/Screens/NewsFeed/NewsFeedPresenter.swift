
import Foundation


protocol NewsFeedViewEmpl: class {
    func showContent(forState state: TableViewState)
    func showFilters(selectedFilter filter: String?, filters: [String])
    func hideFiltres()
}

protocol NewsFeedViewActions: class {
    func viewDidLoad()
    func filtersButtonTapped()
    func wasSelectedFilter(filter: String?)
}


final class NewsFeedPresenter {
    
    //MARK: - Private properties
    private let view: NewsFeedViewEmpl
    private let coordinator: NewsFeedImpl
    private let newsFeedRepo: NewsFeedRepoImplementation
    
    private var filter: String?
    
    //MARK: - Init
    init(view: NewsFeedViewEmpl, repo: NewsFeedRepoImplementation, coordinator: NewsFeedImpl) {
        self.view = view
        self.newsFeedRepo = repo
        self.coordinator = coordinator
    }
}



//MARK: - NewsFeedViewActions
extension NewsFeedPresenter: NewsFeedViewActions {
    func filtersButtonTapped() {
        newsFeedRepo.getCategories { [weak self] categories in
            self?.view.showFilters(selectedFilter: self?.filter,
                                   filters: categories)
        }
    }
    
    func wasSelectedFilter(filter: String?) {
        self.filter = filter
        view.hideFiltres()
    }
    
    
    func viewDidLoad() {
        newsFeedRepo.getNewsFeed { [weak self] result in
            
            guard let `self` = self
                else { return }
            
            switch result {
            case .success(let news):
                self.view.showContent(forState: .success(value: news))
                break
            case .failure(let error):
                self.view.showContent(forState: .failed(state: error))
            }
        }
    }
}
