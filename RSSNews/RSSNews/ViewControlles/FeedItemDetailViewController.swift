//
//  FeedItemDetailViewController.swift
//  RSSNews
//
//  Created by Tulai Dima on 2.02.23.
//

import UIKit

class FeedItemDetailViewController: UIViewController {
    var feedItemDetailModel: FeedItemDetailModel!
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let newsImageView = UIImageView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
        configContentOfElements()
    }
    
    func configureUIElements() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(newsImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(descriptionLabel)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: guide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            newsImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        
        descriptionLabel.font = UIFont.systemFont(ofSize: 24)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.numberOfLines = 0
        
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.textColor = .lightGray
        
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.layer.borderColor = UIColor.lightGray.cgColor
        newsImageView.layer.borderWidth = 0.5
        newsImageView.layer.cornerRadius = 8
        newsImageView.clipsToBounds = true
    }
    func configContentOfElements(){
        titleLabel.text = feedItemDetailModel.item.title
        descriptionLabel.text = feedItemDetailModel.item.articleDescription
        newsImageView.image = feedItemDetailModel.item.image
        let date = feedItemDetailModel.item.date
        let now = Date()
        let components = Calendar.current.dateComponents([.hour, .minute], from: date , to: now)
        
        if let hours = components.hour, hours < 1 {
            let minutes = components.minute ?? 0
            dateLabel.text = "\(minutes) minutes ago"
        } else if let hours = components.hour, hours < 24 {
            dateLabel.text = "\(hours) hours ago"
        } else {
            dateLabel.text = dateFormatter.string(from: date )
        }
        
    }
}
