//
//  RealmManager.swift
//  RSSNews
//
//  Created by Tulai Dima on 2.02.23.
//

import UIKit
import RealmSwift
import FeedKit

class RealmManager {
    static let shared = RealmManager()
    
    private init() {}
    
    var realm: Realm {
        do {
            return try Realm()
        } catch let error as NSError {
            fatalError("Error opening realm: \(error)")
        }
    }
    
    func saveNewsArticle(_ articles: [RSSFeedItem]) {
        DispatchQueue.global(qos: .background).async {
            let realm = try! Realm()
            for item in articles {
                do {
                    let newsArticle = NewsArticle()
                    newsArticle.title = item.title!
                    newsArticle.date = item.pubDate!
                    newsArticle.articleDescription = item.description!
                    
                    if let enclosure = item.enclosure {
                        newsArticle.imageURL = enclosure.attributes?.url ?? ""
                    }
                    
                    let predicate = NSPredicate(format: "title == %@ && date == %@", newsArticle.title, newsArticle.date as NSDate)
                    if realm.objects(NewsArticle.self).filter(predicate).count == 0 {
                        try realm.write {
                            realm.add(newsArticle)
                        }
                    }
                } catch let error as NSError {
                    print("Error saving article: \(error)")
                }
            }
        }
    }

    func retrieveNewsArticles() -> [NewsArticle] {
        let articles = realm.objects(NewsArticle.self)
        var result = [NewsArticle]()
        for article in articles {
            result.append(article)
        }
        return result
    }
    
    func deleteAllNewsArticles() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            print("Error deleting all articles: \(error)")
        }
    }
    func findNewsArticle(withTitle title: String, andDate date: Date) -> NewsArticle? {
        let predicate = NSPredicate(format: "title == %@ && date == %@", title, date as NSDate)
        let articles = realm.objects(NewsArticle.self).filter(predicate)
        return articles.first
    }
    
    func markNewsArticleAsRead(withTitle title: String, andDate date: Date) {
        guard let article = findNewsArticle(withTitle: title, andDate: date) else { return }
        do {
            try realm.write {
                article.isRead = true
            }
        } catch let error as NSError {
            print("Error marking article as read: \(error)")
        }
    }
}


