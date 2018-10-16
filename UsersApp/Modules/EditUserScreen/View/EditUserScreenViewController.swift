//
//  EditUserModuleViewController.swift
//  UsersApp
//
//  Created by maryan on 12/10/2018.
//  Copyright © 2018 Maryan Company. All rights reserved.
//

import UIKit
import SDWebImage

class EditUserScreenViewController: AbstractViewController, EditUserScreenViewInput, ModuleInputProvider, EditUserHeaderDelegate {

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
        notificationsSetup()
    }

    // MARK: EditUserModuleViewInput
    func setupInitialState() {
    }
    
    // MARK: - Private Methods
    private func registerNibs() {
        let userCellNib = UINib(nibName: EditUserCell.nibName, bundle: nil)
        tableView.register(userCellNib, forCellReuseIdentifier: EditUserCell.reuseIdentifier)
        let headerNib = UINib(nibName: String(describing: EditUserHeader.self), bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: String(describing: EditUserHeader.self))
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
    
    private func notificationsSetup() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Notifications
    @objc func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo
        if  let size = info?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect {
            let  contentInset = UIEdgeInsets(top: 0, left: 0, bottom: size.height, right: 0)
            tableView.contentInset = contentInset
            tableView.scrollIndicatorInsets = contentInset;
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }
    
    
    // MARK: - Actions
    @objc func actionSaveButtonTouchUpInside(_ sender: UIBarButtonItem) {
        guard   let firstNameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? EditUserCell,
            let lastNameCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? EditUserCell,
            let emailCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? EditUserCell
            else { return }
        
        let firstName = firstNameCell.inputTextField.text ?? ""
        let lastName = lastNameCell.inputTextField.text ?? ""
        let email = emailCell.inputTextField.text ?? ""
        
        if let header = tableView.headerView(forSection: 0) as? EditUserHeader{
            if let image = header.userImageView.image {
                let user = UserInputModel.init(id: inputUser?.id, first_name: firstName, last_name: lastName, email: email)
                self.output.saveButtonTouchedWith(user: user, imageVO:ImageVO(image: image))
            }
        }
    }
    
    //MARK: EditUserHeaderDelegate
    func avatarViewTapped(_ sender: EditUserHeader) {
        self.output.showPhotoPicker()
    }
    
    
    //MARK: - EditUserScreenViewInput
    func choosePickerAlert() {
        let picker = UIImagePickerController()
        picker.delegate = self
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let actionGallery = UIAlertAction(title: "Gallery", style: .default) { (action) in
            picker.delegate = self
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
        }
        let actionCamera = UIAlertAction(title: "Camera", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.delegate = self
                picker.sourceType = .camera
                self.present(picker, animated: true, completion: nil)
            }
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(actionGallery)
        alertController.addAction(actionCamera)
        alertController.addAction(actionCancel)
        self.present(alertController, animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: EditUserHeader.self)) as? EditUserHeader {
            if let user = inputUser {
                headerView.setUserImageWithUrl(url: user.image_url)
            }
            headerView.delegate = self
            return headerView
        } else { return nil }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.height * 0.2
    }
    
}


extension EditUserScreenViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let header = tableView.headerView(forSection: 0) as? EditUserHeader{
                header.setUserImage(image: image)
            }
        }
        dismiss(animated:true, completion: nil)
    }
}



