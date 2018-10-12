//
//  EditUserModuleViewController.swift
//  UsersApp
//
//  Created by maryan on 12/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//

import UIKit

class EditUserScreenViewController: AbstractViewController, EditUserScreenViewInput, ModuleInputProvider {

    // MARK: - ModuleInputProvider
    var moduleInitialInput: ModuleInput? {
        return self.output as? ModuleInput
    }

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var output: EditUserScreenViewOutput!
    var visualObjects = ["First name:", "Last name:", "Email:"]
    var inputUser: UserResponse?
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        registerNibs()
        setupView()
    }

    // MARK: EditUserModuleViewInput
    func setupInitialState() {
    }
    
    // MARK: - Private Methods
    private func registerNibs() {
        let userCellNib = UINib(nibName: EditUserCell.nibName, bundle: nil)
        tableView.register(userCellNib, forCellReuseIdentifier: EditUserCell.reuseIdentifier)
    }
    
    private func setupView() {
        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.text = "Editing User"
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
        
        let addButton = UIBarButtonItem.init(title: "Save", style: .plain, target: self, action: #selector(actionSaveButtonTouchUpInside(_:)))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    private func updateCellsWith(_ contact: UserResponse, cell: EditUserCell, index: IndexPath) {
        var title = ""
        switch index.row {
        case 0:
            title = contact.first_name
        case 1:
            title = contact.last_name
        case 2:
            title = contact.email
        default: break
        }
        cell.inputTextField.text = title
    }
    
    
    // MARK: - Actions
    @objc func actionSaveButtonTouchUpInside(_ sender: UIBarButtonItem) {
        guard   let firstNameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? EditUserCell,
            let lastNameCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? EditUserCell,
            let emailCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? EditUserCell
            else { return }

        let firstName = firstNameCell.inputTextField.text
        let lastName = lastNameCell.inputTextField.text
        let email = emailCell.inputTextField.text
        
        self.output.saveButtonTouchedWith(firstName: firstName, lastName: lastName, email: email, id: inputUser?.id)
    }
}

extension EditUserScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visualObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EditUserCell.reuseIdentifier) as? EditUserCell else { return UITableViewCell() }
        cell.configureWith(visualObjects[indexPath.row])
        if let user = inputUser {
            updateCellsWith(user, cell: cell, index: indexPath)
        }
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
