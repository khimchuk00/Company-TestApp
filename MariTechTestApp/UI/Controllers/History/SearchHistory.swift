import UIKit

protocol SearchHistoryDelegate: class {
    func didSelected(historyItem: PhotoObject)
}

class SearchHistory: UITableViewController {
    
    var historyViewModel: HistoryViewModel!
    
    weak var delegate: SearchHistoryDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: HistoryResultCell.self)
        tableView.tableFooterView = UIView()
        setupObserver()
    }
    
    func setupObserver() {
        historyViewModel.$historyItems.observe { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        historyViewModel.historyItems.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "History:"
        label.textAlignment = .left
        return label
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelected(historyItem:  historyViewModel.historyItems[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(cellType: HistoryResultCell.self)
        cell.configure(photoObject:  historyViewModel.historyItems[indexPath.row])
        return cell
    }
}


