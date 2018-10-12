//
//  EditUserCell.swift
//  UsersApp
//
//  Created by Maryan Pasichniak on 10/12/18.
//  Copyright © 2018 Maryan Pasichniak. All rights reserved.
//

import UIKit

class EditUserCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!

    // MARK: Static
    static let nibName = "EditUserCell"
    static let reuseIdentifier = "EditUserCell"
    
    // MARK: - Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWith(_ vo: String) {
        self.titleLabel.text = vo
    }

}
