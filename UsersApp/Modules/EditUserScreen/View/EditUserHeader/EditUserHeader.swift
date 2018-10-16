//
//  MyAccountHeaderView.swift
//  SaQure
//
//  Created by Maryan Pasichniak on 8/3/18.
//  Copyright © 2018 SaQure. All rights reserved.
//

import UIKit
import SDWebImage

protocol EditUserHeaderDelegate: class {
    func avatarViewTapped(_ sender: EditUserHeader)
}

class EditUserHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet private weak var addButton: UIButton!
    weak var delegate: EditUserHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImageView.clipsToBounds = true
        self.userImageView.layer.cornerRadius = self.userImageView.frame.height / 2.0
        self.setUserImage(image: nil)
    }
    
    @IBAction func actionAddPhotoButtonTouchUpInside(_ sender: Any) {
        self.delegate?.avatarViewTapped(self)
    }
    
    // MARK: - Public
    func setUserImage(image: UIImage?) {
        if let image = image {
            self.userImageView.image = image
        } else {
            self.userImageView.image = UIImage(imageLiteralResourceName: "userIcon")
        }
    }
    
    func setUserImageWithUrl(url: String) {
         let placeHolder = UIImage.init(named: "userIcon")
        self.userImageView.sd_setImage(with: URL(string: url), placeholderImage: placeHolder, options: .retryFailed, completed: nil)
    }
}
