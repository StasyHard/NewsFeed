
import UIKit


class EmptyView: UIView {
    
    //MARK: - Private properties
    private lazy var errorImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var indicatorView: UIActivityIndicatorView = {
        let ingicator = UIActivityIndicatorView()
        let transform = CGAffineTransform(scaleX: 2, y: 2)
        ingicator.transform = transform
        return ingicator
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center;
        return label
    }()
    
    private let viewHeight: CGFloat = 50.0
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    
    //MARK: - Open metods
    func setViewWithState(_ state: TableViewState) {
        var view: UIView
        
        switch state {
        case .failed(state: let error):
            view = getErrorView(withError: error)
            descriptionLabel.text = getDescriptinText(forError: error)
        case .loading:
            view = indicatorView
            indicatorView.startAnimating()
            descriptionLabel.text = "Загрузка..."
        default:
            view = UIView()
        }
        
        self.addSubview(view)
        self.addSubview(descriptionLabel)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.bottomAnchor
            .constraint(equalTo: self.centerYAnchor).isActive = true
        view.centerXAnchor
            .constraint(equalTo: self.centerXAnchor).isActive = true
        view.heightAnchor
            .constraint(equalToConstant: 50).isActive = true
        view.widthAnchor
            .constraint(equalTo: view.heightAnchor).isActive = true
        
        
        descriptionLabel.topAnchor
            .constraint(equalTo: view.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor
            .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor
            .constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    
    //MARK: - Private metods
    private func setupUI() {
        self.backgroundColor = AppColors.backgroungColor
    }
    
    private func getErrorView(withError error: NetworkResponseError) -> UIView {
        switch error {
        case .notConnectedToInternet:
            errorImageView.image = UIImage(named: "networkError")!
        default:
            errorImageView.image = UIImage(named: "error")!
        }
        return errorImageView
    }
    
    private func getDescriptinText(forError error: NetworkResponseError) -> String {
        switch error {
        case .notConnectedToInternet:
            return "Интернет соединение отсутствует."
        default:
            return "Ошибка.\nПовторите попытку позже."
        }
    }
}
