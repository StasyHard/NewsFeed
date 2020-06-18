
import Foundation

protocol DetailsNewsViewEmpl: class {
    func showNews(_ news: NewsItem)
}

protocol DetailsNewsViewActions: class {
    
}


final class DetailsNewsPresenter {
    
    //MARK: - Private properties
    private let view: DetailsNewsViewEmpl
    
    
    //MARK: - Init
    init(view: DetailsNewsViewEmpl, news: NewsItem) {
        self.view = view
        view.showNews(news)
    }
}



extension DetailsNewsPresenter: DetailsNewsViewActions {
    
}
