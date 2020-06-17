
import Foundation


protocol NewsFeedViewEmpl: class {
    func showContent(forState state: TableViewState)
    func showFilters(selectedFilter filter: String?, filters: [String])
    func hideFiltres()
}

protocol NewsFeedViewActions: class {
    func viewDidLoad()
    func reloadData()
    func filtersButtonTapped()
    func wasSelectedFilter(filter: String?)
    func wasSelectedNews(news: NewsItem)
}


final class NewsFeedPresenter {
    
    //MARK: - Private properties
    private let view: NewsFeedViewEmpl
    private let coordinator: NewsFeedСoordination
    private let newsFeedRepo: NewsFeedRepoImplementation
    
    private var filter: String?
    
    //MARK: - Init
    init(view: NewsFeedViewEmpl, repo: NewsFeedRepoImplementation, coordinator: NewsFeedСoordination) {
        self.view = view
        self.newsFeedRepo = repo
        self.coordinator = coordinator
    }
}



//MARK: - NewsFeedViewActions
extension NewsFeedPresenter: NewsFeedViewActions {
    
    func viewDidLoad() {
        view.showContent(forState: .loading)
        getNewsFromRepo(withFilter: self.filter)
    }
    
    func reloadData() {
        getNewsFromRepo(withFilter: self.filter)
    }
    
    func filtersButtonTapped() {
        newsFeedRepo.getCategories { [weak self] categories in
            self?.view.showFilters(selectedFilter: self?.filter,
                                   filters: categories)
        }
    }
    
    func wasSelectedFilter(filter: String?) {
        view.hideFiltres()
        
        if filter != self.filter {
            self.filter = filter
            view.showContent(forState: .loading)
            getNewsFromRepo(withFilter: filter)
        }
    }
    
    func wasSelectedNews(news: NewsItem) {
        coordinator.showDetails(forNews: news)
    }
    
    
    //MARK: - Private metods
    private func getNewsFromRepo(withFilter filter: String?) {
        
        newsFeedRepo.getNewsFeed(withFilter: filter) { [weak self] result in
            
            guard let `self` = self
                else { return }
            
            switch result {
            case .success(let news):
                self.view.showContent(forState: .success(value: news))
            case .failure(let error):
                self.view.showContent(forState: .failed(state: error))
            }
        }
    }
}
