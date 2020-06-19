
import Foundation


extension String {
    
    func getFormattedDate(currentFomat:String, expectedFromat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentFomat
        dateFormatter.timeZone = TimeZone.current
        
        guard let date = dateFormatter.date(from: self)
            else { return nil }
        
        dateFormatter.dateFormat = expectedFromat
        return dateFormatter.string(from: date)
    }
    
}
