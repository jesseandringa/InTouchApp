//
//  FeedPostHeaderTableViewCell.swift
//  InTouch
//
//  Created by jesse andringa on 3/12/23.
//

import UIKit

class FeedPostHeaderTableViewCell: UITableViewCell {
    static let identifier = "FeedPostHeaderTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(){
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
