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
                self?.news = self?.convertRSStoNews(rssNews: self?.feedItems ?? []) ?? []
                RealmManager.shared.saveNewsArticle(feed.rssFeed?.items ?? [])
                //self?.news = self?.convertRealmtoNews(realmNews: RealmManager.shared.retrieveNewsArticles()) ?? []
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
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

