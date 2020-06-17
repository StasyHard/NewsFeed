
import Foundation


protocol ReusableView: class {}


extension ReusableView {
    
    static var reuseId: String {
        return String(describing: self)
    }
    
}
