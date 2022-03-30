//
//  ViewController.swift
//  WebViewApp
//
//  Created by Aloc FL00030 on 29/03/22.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    // MARK: - Lazy Properties
    
    lazy var webView: WKWebView = {
        let view = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.navigationDelegate = self
        return view
    }()
    
    lazy var searchViewController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        return controller
    }()
    
    // MARK: - Private Variables
    
    private var searchText: String = "https://apple.com"
    
    // MARK: - View Controller Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = .white
        title = "Navegador"
        setupNavigationBar()
        setupNavigationController()
        setupSearchController()
        setupWebViewLayout()
        
        loadWebURL()
        verifyNavigationButtons()
    }

    // MARK: - Navigation Controller Setup Functions
    
    private func setupNavigationBar() {
        
        let reloadButton = UIBarButtonItem(image: UIImage(systemName: "gobackward"), style: .plain, target: self, action: #selector(webReload))
        
        let goBackButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(webGoBack))

        let goFowardButton = UIBarButtonItem(image: UIImage(systemName: "arrow.forward"), style: .plain, target: self, action: #selector(webGoFoward))
        
        navigationItem.leftBarButtonItems = [reloadButton]
        navigationItem.rightBarButtonItems = [goFowardButton, goBackButton]

    }
    
    private func setupNavigationController() {
        navigationItem.searchController = searchViewController
        navigationItem.hidesSearchBarWhenScrolling = true
        self.definesPresentationContext = true
    }
    
    // MARK: - Search Controller Setup
    
    private func setupSearchController() {
        searchViewController.searchBar.autocapitalizationType = .none
        searchViewController.searchBar.autocorrectionType = .no
        searchViewController.hidesNavigationBarDuringPresentation = false
        searchViewController.automaticallyShowsCancelButton = false
        
        searchViewController.searchResultsUpdater = self
        searchViewController.searchBar.text = searchText
        
        searchViewController.delegate = self
        searchViewController.searchBar.delegate = self
        
        searchViewController.searchBar.clearsContextBeforeDrawing = false
        
        searchViewController.searchBar.sizeToFit()
    }
    
    // MARK: - Layout Setup Functions
    
    private func setupWebViewLayout() {
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Web Navigation Functions
    
    @objc private func webReload() {
        webView.reload()
    }
    
    @objc private func webGoBack() {
        webView.goBack()
    }
    
    @objc private func webGoFoward() {
        webView.goForward()
    }
    
    private func validateSearchText(search: String) -> String {
        var newSearch: String = search
        
        if search.hasPrefix("www.") ||
            (!search.hasPrefix("https://")
             && !search.hasPrefix("http://")
             && search.contains(".") ){
            
            newSearch = "https://\(search)"
        } else if !search.hasPrefix("https://")
               && !search.hasPrefix("http://")
               && !search.contains(".") {
            newSearch = "https://google.com/search?q=\(search)"
        }
        
        return newSearch
    }
    
    private func loadWebURL() {
        guard let url = URL(string: searchText) else { return }
        webView.load(URLRequest(url: url))
        verifyNavigationButtons()
    }
    
    private func verifyNavigationButtons() {
        if let barButtons = navigationItem.rightBarButtonItems,
           barButtons.count > 2 {
            barButtons[1].tintColor = webView.canGoBack ? .blue : .gray
            barButtons[0].tintColor = webView.canGoForward ? .blue : .gray
        }
    }
}

extension ViewController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let newText = searchBar.text, newText.count > 0, newText != searchText {
            self.searchText = validateSearchText(search: newText)
            loadWebURL()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension ViewController: WKNavigationDelegate {
    
}

