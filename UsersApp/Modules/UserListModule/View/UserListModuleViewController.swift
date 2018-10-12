//
//  UserListModuleViewController.swift
//  UsersApp
//
//  Created by maryan on 11/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//

import UIKit

class UserListModuleViewController: AbstractViewController, UserListModuleViewInput, ModuleInputProvider {

    // MARK: - ModuleInputProvider
    var moduleInitialInput: ModuleInput? {
        return self.output as? ModuleInput
    }

    // MARK: - Properties
    var output: UserListModuleViewOutput!
    @IBOutlet weak var tableView: UITableView!
    var usersData: [UserResponse] = []
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
        registerNibs()
        setupView()
    }

    // MARK: UserListModuleViewInput
    func setupInitialState() {
    }
    
    func updateWithUser(_ userData: [UserResponse]) {
        self.usersData = userData
        tableView.reloadData()
    }
    
    // MARK: - Private Methods
    private func registerNibs() {
        let userCellNib = UINib(nibName: UserListCell.nibName, bundle: nil)
        tableView.register(userCellNib, forCellReuseIdentifier: UserListCell.reuseIdentifier)
    }
    
    private func setupView() {
        let titleLabel = UILabel(frame: CGRect.zero)
        titleLabel.text = "Users"
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(actionAddButtonTouchUpInside(_:)))
        self.navigationItem.rightBarButtonItem = addBarButton
    }
    
    // MARK: - Actions
    @objc func actionAddButtonTouchUpInside(_ sender: UIBarButtonItem) {
        self.output.addButtonTouchedWith(nil)
    }
}

extension UserListModuleViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserListCell.reuseIdentifier) as? UserListCell else
        { return UITableViewCell() }
        cell.configureWith(usersData[indexPath.row])
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.output.addButtonTouchedWith(usersData[indexPath.row])
    }
}
