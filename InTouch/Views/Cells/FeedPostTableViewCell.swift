//
//  FeedPostTableViewCell.swift
//  InTouch
//
//  Created by jesse andringa on 3/12/23.
//
import AVFoundation
import UIKit
import SDWebImage

//lCELL for primary post ocntent
final class FeedPostTableViewCell: UITableViewCell {

    static let identifier = "FeedPostTableViewCell"
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        return imageView
    }()
    
    private var player: AVPlayer? VIDEO 15>>>> 5:00 into it
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(postImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post: UserPost){
        postImageView.image = UIImage(named: "test")
        switch post.postType{
        case .photo:
            postImageView.sd_setImage(with: post.postURL,completed: nil)
            //show image
        case .video:
            
            //load and play video
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        postImageView.frame = contentView.bounds // full size of the space
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
}

