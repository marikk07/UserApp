//
//  UserListCell.swift
//  UsersApp
//
//  Created by Maryan Pasichniak on 10/11/18.
//  Copyright © 2018 Maryan Pasichniak. All rights reserved.
//

import UIKit
import SDWebImage

class UserListCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: Static
    static let nibName = "UserListCell"
    static let reuseIdentifier = "UserListCell"
    
    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    // MARK: - Private Methods
    fileprivate func setupView() {
    }
    
    // MARK: - Public Methods
    func configureWith(_ user: UserResponse) {
        nameLabel.text = user.first_name + " " + user.last_name
        emailLabel.text = user.email
        let placeHolder = UIImage.init(named: "userIcon")
        iconImageView.sd_setImage(with:  URL(string: user.image_url), placeholderImage: placeHolder, options: .retryFailed, completed: nil)
    }
    
}
