//
//  NewsFeedViewControllerModel.swift
//  RSSNews
//
//  Created by Tulai Dima on 1.02.23.
//

import UIKit
import FeedKit
import Kingfisher

class NewsFeedModel{
    var feedItems = [RSSFeedItem]()
    var news = [News]()
    var realmNews = [NewsArticle]()
    
    let resource = URL(string: Resources.lentaRu.rawValue)!
    
    func loadFeedItems(completion: @escaping(_ error: Error?) -> Void) {
        let parser = FeedParser(URL: resource)
        parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { [weak self] (result) in
            switch result {
            case .success(let feed):
                self?.feedItems = feed.rssFeed?.items ?? []
                RealmManager.shared.saveNewsArticle(feed.rssFeed?.items ?? []) 
                    self?.convNew()
                    completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func convNew() {
        realmNews = RealmManager.shared.retrieveNewsArticles()
        news = realmNews.map({ article in
            self.newsArticleToNews(article)
        })
        print(news.count)
    }
    
    func rSSFeedItemToNews(_ article: RSSFeedItem) -> News {
        if let enclosure = article.enclosure, let imageURL = URL(string: enclosure.attributes?.url ?? "") {
            let image = try! UIImage(data: Data(contentsOf: imageURL))
            return News(title: article.title!, date: article.pubDate!, articleDescription: article.description!, image: image!, isRead: false)
        }
        return News(title: article.title!, date: article.pubDate!, articleDescription: article.description!, image: nil, isRead: false)
    }
    func newsArticleToNews(_ article: NewsArticle) -> News{
        return News(title: article.title, date: article.date, articleDescription: article.articleDescription, image: UIImage(data: article.imageData!)!, isRead: article.isRead)
    }
    
    func calculateRowHeight(from frameHeight: CGFloat) -> CGFloat {
        var rowHeight: CGFloat
        switch true {
        case frameHeight < 670: rowHeight = frameHeight / 4.5
        case frameHeight > 900: rowHeight = frameHeight / 5.5
        default: rowHeight = frameHeight / 5.2
        }
        return rowHeight
    }
}

