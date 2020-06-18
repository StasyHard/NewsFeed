
import UIKit


final class FiltersView: UIView {
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var contentView: UIView!
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
        animateСlosed()
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
        animateAppearance()
    }
    
    @objc private func onClickFiltersView() {
        hideFiltres()
    }
    
    private func animateAppearance() {
        backgroundView.alpha = 0
        contentView.frame = CGRect(x: 0,
                                   y: containerView.bounds.height,
                                   width: contentView.bounds.width,
                                   height: contentView.bounds.height)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut,
                       animations: {
                        self.backgroundView.alpha = 1
                        self.contentView.frame = CGRect(x: 0,
                                                        y: self.containerView.bounds.height - self.contentView.bounds.height,
                                                        width: self.contentView.bounds.width,
                                                        height: self.contentView.bounds.height)
        },
                       completion: nil)
    }
    
    private func animateСlosed() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut,
                       animations: {
                        self.backgroundView.alpha = 0
                        self.contentView.frame = CGRect(x: 0,
                                                        y: self.containerView.bounds.height,
                                                        width: self.contentView.bounds.width,
                                                        height: self.contentView.bounds.height)
        },
                       completion: { _ in
                        self.removeFiltersView()
        })
    }
    
    private func removeFiltersView() {
        if let window = UIWindow.key {
            window.subviews.forEach {
                if $0 is FiltersView {
                    $0.removeFromSuperview()
                }
            }
        }
    }
}



//MARK: - UIGestureRecognizerDelegate
extension FiltersView: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchedView = touch.view,
            touchedView != backgroundView {
            return false
        }
        return true
    }
}
