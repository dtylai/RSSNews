//
//  ViewController.swift
//  RSSNews
//
//  Created by Tulai Dima on 1.02.23.
//

import UIKit

class NewsFeedViewController: UIViewController {
    var newsFeedModel = NewsFeedModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadNews()
    }
    
    func configureTableView() {
        tableView.rowHeight = newsFeedModel.calculateRowHeight(from: tableView.frame.size.height)
        tableView.register(FeedItemCell.self, forCellReuseIdentifier: FeedItemCell.reuseIdentifier)
    }
    
    func loadNews() {
        newsFeedModel.loadFeedItems(from: URL(string: "https://lenta.ru/rss")!) { error in
            if let error = error {
                print("Failed to parse RSS feed: \(error)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension NewsFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeedModel.feedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedItemCell.reuseIdentifier, for: indexPath) as! FeedItemCell
        let item = newsFeedModel.feedItems[indexPath.row]
        
        cell.configure(with: item)
        
        return cell
    }
}
extension NewsFeedViewController: UITableViewDelegate {
}
