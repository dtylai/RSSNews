//
//  FeedItemDetailViewController.swift
//  RSSNews
//
//  Created by Tulai Dima on 2.02.23.
//

import UIKit

class FeedItemDetailViewController: UIViewController {
    var feedItemDetailModel: FeedItemDetailModel!
    
    @IBOutlet private var dateLable: UILabel!
    @IBOutlet private var descriptionTextView: UITextView!
    @IBOutlet private var titleLAble: UILabel!
    @IBOutlet private var imageOfNews: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configContentOfElements()
    }
    func configContentOfElements(){
        titleLAble.text = feedItemDetailModel.item.title
        descriptionTextView.text = feedItemDetailModel.item.articleDescription
        dateLable.text = feedItemDetailModel.item.date.description
        imageOfNews.image = feedItemDetailModel.item.image
    }
}
