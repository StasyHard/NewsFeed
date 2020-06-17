
import UIKit


protocol FiltersTableViewProviderImpl {
    func setActionDelegate(delegate: NewsFeedViewActions?)
    func setFilters(selectedFilter filter: String?, filters: [String])
}


final class FiltersTableViewProvider: NSObject, TableViewProvider {
    
    enum FiltersSection: CaseIterable {
        case all
        case filter
    }
    
    //MARK: - Open properties
    private var actionsDelegate: NewsFeedViewActions?
    
    private var filters: [String]?
    private var selectedIndexPath: IndexPath?
    
    
    //MARK: - Private metods
    private func getSelectedFilter() -> String? {
        let allIndexPath = IndexPath(row: 0, section: 0)
        if let indexPath = selectedIndexPath, indexPath != allIndexPath {
            return filters?[indexPath.row]
        }
        else {
            return nil
        }
    }
    
    
    //MARK: - TableViewProvider
    func numberOfSections(in tableView: UITableView) -> Int {
        return FiltersSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sect = FiltersSection.allCases[section]
        
        switch sect {
        case .all: return 1
        case .filter: return filters?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let section = FiltersSection.allCases[indexPath.section]
        let cell = UITableViewCell()
        
        switch section {
        case .all:
            cell.textLabel?.text = "Все категории"
        case .filter:
            let category = filters?[indexPath.row]
            cell.textLabel?.text = category
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        if indexPath == selectedIndexPath {
            cell.accessoryType = .checkmark
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let oldSelectIndexPath = selectedIndexPath
        selectedIndexPath = indexPath
        tableView.reloadRows(at: [oldSelectIndexPath!, selectedIndexPath!], with: .automatic)
        actionsDelegate?.wasSelectedFilter(filter: getSelectedFilter())
    }
}



extension FiltersTableViewProvider: FiltersTableViewProviderImpl {
    
    func setActionDelegate(delegate: NewsFeedViewActions?) {
        self.actionsDelegate = delegate
    }
    
    
    //MARK: - Open metods
    func setFilters(selectedFilter filter: String?, filters: [String]) {
        self.filters = filters
        
        if
            let filter = filter,
            let row = filters.firstIndex(of: filter) {
            selectedIndexPath = IndexPath(row: row, section: 1)
        }
        else {
            selectedIndexPath = IndexPath(row: 0, section: 0)
        }
    }
    
}
