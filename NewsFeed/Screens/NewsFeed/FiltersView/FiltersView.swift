
import UIKit


final class FiltersView: UIView {
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet private weak var filtersTableView: UITableView! {
        didSet {
            filtersTableView.tableFooterView = UIView()
        }
    }
    
    
    //MARK: - Private properties
    private var actionDelegate: NewsFeedViewActions?
    private lazy var contentTableViewProvider: FiltersTableViewProviderImpl = {
        let provider = FiltersTableViewProvider()
        filtersTableView.delegate = provider
        filtersTableView.dataSource = provider
        return provider
    }()
    
    
    //MARK: - Init
     init(frame: CGRect, actionDelegate: NewsFeedViewActions?) {
        self.actionDelegate = actionDelegate
        super.init(frame: frame)
        commonInit()
        addTapGesture()
        initSubViews()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addTapGesture()
        initSubViews()
    }
    
    
    //MARK: - Open metods
    func showFilters(selectedFilter filter: String?, filters: [String]) {
        contentTableViewProvider.setActionDelegate(delegate: actionDelegate)
        contentTableViewProvider.setFilters(selectedFilter: filter, filters: filters)
        filtersTableView.reloadData()
    }
    
    func hideFiltres() {
        if let window = UIWindow.key {
            window.subviews.forEach {
                if $0 is FiltersView {
                    $0.removeFromSuperview()
                }
            }
        }
    }
    
    //MARK: - IBAction
    @IBAction private func closeButtonTapped(_ sender: UIButton) {
           hideFiltres()
       }
    
    
    //MARK: - Private metods
    private func commonInit() {
        if let window = UIWindow.key {
            window.addSubview(self)
        }
    }
    
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(onClickFiltersView))
        self.addGestureRecognizer(tapGesture)
        tapGesture.delegate = self
    }
    
    private func initSubViews() {
        Bundle.main.loadNibNamed("FiltersView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @objc func onClickFiltersView() {
        hideFiltres()
    }
}



//MARK: - UIGestureRecognizerDelegate
extension FiltersView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchedView = touch.view,
            touchedView != containerView {
            return false
        }
        return true
    }
}
