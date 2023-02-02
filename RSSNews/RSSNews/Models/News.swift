//
//  News.swift
//  RSSNews
//
//  Created by Tulai Dima on 2.02.23.
//

import UIKit
import FeedKit

struct News {
    var title: String
    var date: Date
    var articleDescription: String
    var imageURL: String?
    var image: UIImage?
    var isRead: Bool
    
    init(rssItem: RSSFeedItem) {
        self.title = rssItem.title ?? " "
        self.date = rssItem.pubDate ?? Date()
        self.articleDescription = rssItem.description ?? " "
        self.isRead = false
        if let enclosure = rssItem.enclosure {
            self.imageURL = enclosure.attributes?.url ?? " "
        }
    }
    
    init(realmitem: NewsArticle) {
        self.title = realmitem.title
        self.date = realmitem.date
        self.isRead = realmitem.isRead
        self.articleDescription = realmitem.articleDescription
        self.imageURL = realmitem.imageURL
    }
}
