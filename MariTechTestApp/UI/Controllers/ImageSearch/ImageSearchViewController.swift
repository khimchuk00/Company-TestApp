import UIKit

class ImageSearchViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var searchBarContainer: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var searchResultsController: SearchHistory!
    var searchController: UISearchController!
    
    var imageViewModel = ImageViewModel()
    var historyViewModel = HistoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupObserver()
        setupActivityIndicator()
    }
    
    func setupObserver() {
        imageViewModel.$image.observe { [weak self] image in
            self?.stopSpining()
            self?.imageView.image = image
        }
        
        imageViewModel.$error.observeNonNil { [weak self] error in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",style: .default, handler: nil))
            self?.stopSpining()
            self?.present(alert, animated: true)
        }
    }
    
    func setupSearchBar() {
        searchResultsController = SearchHistory()
        searchResultsController.historyViewModel = historyViewModel
        searchResultsController.delegate = self
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Enter image name"
        definesPresentationContext = true
        searchController.delegate = self
        searchController.hidesNavigationBarDuringPresentation = true
        searchBarContainer.addSubview(searchController.searchBar)
        searchController.searchBar.sizeToFit()
    }
    
    func startSearching() {
        searchController.searchBar.resignFirstResponder()
        searchController.dismiss(animated: false)
        guard let text = searchController.searchBar.text, !text.isEmpty else {
            return
        }
        
        imageViewModel.loadImage(for: text)
        startSpining()
    }
    
    func updateSearchHistory() {
        guard let text = searchController.searchBar.text else {return}
        historyViewModel.loadItems(for: text)
    }
    
    func startSpining() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    func stopSpining() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    func setupActivityIndicator() {
        activityIndicator.style = .large
    }
    
}

extension ViewController: SearchHistoryDelegate {
    
    func didSelected(historyItem: PhotoObject) {
        searchController.searchBar.text = historyItem.name
        startSearching()
    }
    
}

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        updateSearchHistory()
    }
}

extension ViewController: UISearchControllerDelegate {
    
    func didPresentSearchController(_ searchController: UISearchController) {
        updateSearchHistory()
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        startSearching()
    }
}

