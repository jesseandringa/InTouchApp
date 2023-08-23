//
//  FeedPostGeneralTableViewCell.swift
//  InTouch
//
//  Created by jesse andringa on 3/12/23.
//

import UIKit

///general cells include likes and comments
class FeedPostGeneralTableViewCell: UITableViewCell {

    static let identifier = "FeedPostGeneralTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemCyan
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
