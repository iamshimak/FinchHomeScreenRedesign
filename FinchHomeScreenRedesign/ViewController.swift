//
//  ViewController.swift
//  FinchHomeScreenRedesign
//
//  Created by Ahamed Shimak on 2022-03-16.
//

import UIKit

enum TopContainerPosition {
    case off, on
}

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var bottomContainer: UIView!
    
    @IBOutlet weak var searchContainer: UIView!
    @IBOutlet weak var tableView: TouchDelegateTableView!
    
    @IBOutlet weak var topContainerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchContainerTopConstraint: NSLayoutConstraint!
    
    private var topContainerPosition: TopContainerPosition = .on
    
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var equalConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
//        tableView.isScrollEnabled = false
        configureRefreshControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func configureRefreshControl() {
        refreshControl.tintColor = UIColor.red
        refreshControl.addTarget(self, action: #selector(update), for: .valueChanged)
        
        scrollView.refreshControl = refreshControl
    }
    
    @objc private func update() {
        refreshControl.endRefreshing()
    }
}

class TouchDelegateTableView: UITableView { }

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = "Cell \(indexPath.row)"
        content.secondaryText = "Hello"
        
        cell.contentConfiguration = content
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxHeight = topContainer.frame.height
        let contentOffSetY = scrollView.contentOffset.y
        let duration = 0.25
        
        print("scrollViewDidScroll | \(scrollView.contentOffset.y) Table View Scrolling: \(tableView.isScrollEnabled)")
        
        if scrollView == tableView && contentOffSetY <= maxHeight {
            topContainerTopConstraint.constant = -(contentOffSetY)
        }
        
//        let maxHeight = topContainer.frame.height
//        let contentOffSetY = scrollView.contentOffset.y
//        let duration = 0.25
//
//        print("scrollViewDidScroll | \(scrollView.contentOffset.y) Table View Scrolling: \(tableView.isScrollEnabled)")
//
//        if scrollView == self.scrollView {
//            equalConstraint.constant = contentOffSetY
//            tableView.isScrollEnabled = contentOffSetY > maxHeight
//
//            return
//        }
    }

}
