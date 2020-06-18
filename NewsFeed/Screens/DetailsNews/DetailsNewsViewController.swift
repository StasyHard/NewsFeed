
import UIKit


class DetailsNewsViewController: UIViewController {
    
    //MARK: - Open properties
    var actionDelegate: DetailsNewsPresenter?
    
    
    //MARK: - Private properties
    private lazy var detailsNewslView = view as? DetailsNewsView
    
}



//MARK: - DetailsNewsViewEmpl
extension DetailsNewsViewController: DetailsNewsViewEmpl {
    
    func showNews(_ news: NewsItem) {
        detailsNewslView?.showNews(news)
    }
    
    
}
