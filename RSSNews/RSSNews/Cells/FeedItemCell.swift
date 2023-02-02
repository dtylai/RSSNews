//
//  FeedItemCell.swift
//  RSSNews
//
//  Created by Tulai Dima on 1.02.23.
//

import UIKit

class FeedItemCell: UITableViewCell {
    static let reuseIdentifier = "FeedItemCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(articleImageView)
        contentView.addSubview(dateLabel)
        
        articleImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            articleImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            articleImageView.widthAnchor.constraint(equalTo: articleImageView.heightAnchor),
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 8),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with article: News) {
        self.backgroundColor = .white
        titleLabel.text = article.title
        
        let date = article.date
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
        
        let url = URL(string: article.imageURL ?? " ")
        articleImageView.kf.indicatorType = .activity
        articleImageView.kf.setImage(with: url)
        
        if article.isRead {
            self.backgroundColor = .gray.withAlphaComponent(0.2)
        }
    }
}

