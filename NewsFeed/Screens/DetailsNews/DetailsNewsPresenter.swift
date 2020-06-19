
import Foundation

protocol DetailsNewsViewImpl: class {
    func showNews(_ news: NewsItem)
}

protocol DetailsNewsViewActions: class {
    
}


final class DetailsNewsPresenter {
    
    //MARK: - Private properties
    private weak var view: DetailsNewsViewImpl?
    
    
    //MARK: - Init
    init(view: DetailsNewsViewImpl, news: NewsItem) {
        self.view = view
        view.showNews(news)
    }
}



extension DetailsNewsPresenter: DetailsNewsViewActions {
    
}
