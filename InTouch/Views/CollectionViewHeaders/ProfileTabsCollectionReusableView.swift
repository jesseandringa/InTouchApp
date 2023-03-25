//
//  ProfileTabsCollectionReusableView.swift
//  InTouch
//
//  Created by jesse andringa on 3/16/23.
//

import UIKit

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsCollectionReusableView"
    override init(frame:CGRect){
        super.init(frame: frame)
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
