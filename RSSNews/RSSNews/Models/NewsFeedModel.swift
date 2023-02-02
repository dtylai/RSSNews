//
//  NewsFeedViewControllerModel.swift
//  RSSNews
//
//  Created by Tulai Dima on 1.02.23.
//

import UIKit
import FeedKit

class NewsFeedModel{
    var news = [News]()
    
    let resource = URL(string: Resources.lentaRu.rawValue)!
    
    func loadFeedItems(completion: @escaping(_ error: Error?) -> Void) {
        let parser = FeedParser(URL: resource)
        
        parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { [weak self] (result) in
            switch result {
            case .success(let feed):
                let rssNews = feed.rssFeed?.items ?? []
                let newNews = self?.convertRSStoNews(rssNews: rssNews) ?? []
                
                self?.news.append(contentsOf: newNews.filter({ news in
                    !(self?.news.contains(where: { existingNews in
                        news.title == existingNews.title && news.date == existingNews.date
                    }))!
                }))
                
                RealmManager.shared.saveNewsArticle(articles: rssNews)
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func loadFromRealm(completion: @escaping() -> Void) {
        self.news = self.convertRealmtoNews(realmNews: RealmManager.shared.retrieveNewsArticles())
        completion()
    }
    
    func convertRealmtoNews(realmNews: [NewsArticle]) -> [News] {
        return realmNews.map({ article in
            return News(realmitem: article)
        })
    }
    
    func convertRSStoNews(rssNews: [RSSFeedItem]) -> [News] {
        return rssNews.map({ item in
            return News(rssItem: item)
        })
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

