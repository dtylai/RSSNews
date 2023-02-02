//
//  NewsArticle.swift
//  RSSNews
//
//  Created by Tulai Dima on 2.02.23.
//

import UIKit
import RealmSwift

class NewsArticle: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var articleDescription: String = ""
    @objc dynamic var imageURL: String = ""
    @objc dynamic var isRead: Bool = false

    convenience init(title: String, date: Date, imageURL: String, articleDescription: String) {
        self.init()
        self.title = title
        self.date = date
        self.articleDescription = articleDescription
        self.imageURL = imageURL
    }
    override static func primaryKey() -> String? {
            return "id"
        }
}

