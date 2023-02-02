//
//  FeedItemDetailViewController.swift
//  RSSNews
//
//  Created by Tulai Dima on 2.02.23.
//

import UIKit
import Kingfisher
import FeedKit

class FeedItemDetailViewController: UIViewController {
    var item: RSSFeedItem!
    
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleLAble: UILabel!
    @IBOutlet weak var imageOfNews: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLAble.text = item.title
        descriptionTextView.text = item.description
        dateLable.text = item.pubDate?.description
        
        if let enclosure = item.enclosure, let imageURL = URL(string: enclosure.attributes?.url ?? "") {
            imageOfNews.kf.setImage(with: imageURL)
        }
    }
}
