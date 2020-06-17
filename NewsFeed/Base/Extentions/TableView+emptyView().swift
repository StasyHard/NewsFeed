
import UIKit


extension UITableView {
    
    func setEmptyView(forState state: TableViewState) {
        let view = EmptyView(frame: CGRect(x: self.center.x,
                                           y: self.center.y,
                                           width: self.bounds.size.width,
                                           height: self.bounds.size.height))
        view.setViewWithState(state)
        
        self.backgroundView = view
    }
    
}
