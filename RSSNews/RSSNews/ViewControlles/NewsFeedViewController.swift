//
//  ViewController.swift
//  RSSNews
//
//  Created by Tulai Dima on 1.02.23.
//

import UIKit

class NewsFeedViewController: UIViewController {
    var newsFeedModel = NewsFeedModel()
    
    let myRefreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        let title = NSLocalizedString("Wait a second", comment: "Pull to refresh")
        refreshControl.attributedTitle = NSAttributedString(string: title)
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        newsFeedModel.convNew()
        print(newsFeedModel.news.count)
        loadNews()
        print(newsFeedModel.news.count)
    }
    
    func configureTableView() {
        tableView.rowHeight = newsFeedModel.calculateRowHeight(from: tableView.frame.size.height)
        tableView.register(FeedItemCell.self, forCellReuseIdentifier: FeedItemCell.reuseIdentifier)
        tableView.refreshControl = myRefreshControl
    }
    
    func loadNews() {
        newsFeedModel.loadFeedItems() { error in
            if let error = error {
                print("Failed to parse RSS feed: \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func showDetailScreen(for item: News) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "FeedItemDetailViewController") as! FeedItemDetailViewController
        detailVC.feedItemDetailModel = FeedItemDetailModel(item: item)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    @objc func refresh(sender: UIRefreshControl) {
        newsFeedModel.loadFeedItems() { error in
            if let error = error {
                print("Failed to parse RSS feed: \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                sender.endRefreshing()
            }
        }
    }
}

extension NewsFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeedModel.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedItemCell.reuseIdentifier, for: indexPath) as! FeedItemCell
        let item = newsFeedModel.news[indexPath.row]
        
        cell.configure(with: item)
        
        return cell
    }
}
extension NewsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = newsFeedModel.news[indexPath.row]
        showDetailScreen(for: item)
    }
}

