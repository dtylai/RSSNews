//
//  NewsFeedViewControllerModel.swift
//  RSSNews
//
//  Created by Tulai Dima on 1.02.23.
//

import Foundation
import FeedKit

class NewsFeedModel{
    var feedItems = [RSSFeedItem]()
    
    func loadFeedItems(from url: URL, completion: @escaping(_ error: Error?) -> Void) {
        let parser = FeedParser(URL: url)
        parser.parseAsync { result in
            switch result {
            case .success(let feed):
                self.feedItems = feed.rssFeed?.items ?? []
                completion(nil)
            case .failure(let error):
                completion(error)
               // print("Failed to parse RSS feed: \(error)")
            }
        }
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
