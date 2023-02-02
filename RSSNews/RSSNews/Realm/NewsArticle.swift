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
    @objc dynamic var imageData: Data?
    @objc dynamic var isRead: Bool = false

    convenience init(title: String, date: Date, image: UIImage?, articleDescription: String) {
        self.init()
        self.title = title
        self.date = date
        self.articleDescription = articleDescription
        self.imageData = image?.pngData()
    }
    override static func primaryKey() -> String? {
            return "id"
        }
}

