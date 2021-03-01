import Foundation

class HistoryViewModel {
    
    @BindingValue var historyItems = [PhotoObject]()
    
    func loadItems(for text: String) {
        if !text.isEmpty {
            historyItems = RealmManager.shared.getObjects().filter{
                $0.name.uppercased().contains(text.uppercased())
            }
        } else {
            historyItems = RealmManager.shared.getObjects()
        }
    }
}
