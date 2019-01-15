//
//  SettingTableViewController.swift
//  Social
//
//  Created by Vitali Zhytniakivskyi on 12.03.18.
//  Copyright © 2018 Vitali Zhytniakivskyi. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol SettingTableViewControllerDelegate {
    func updateUserInfor()
}

class SettingTableViewController: UITableViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var delegate: SettingTableViewControllerDelegate?
    
    @IBAction func saveBtn_TouchUpInside(_ sender: Any) {
        if let profileImg = self.profileImageView.image, let imageData = UIImageJPEGRepresentation(profileImg, 0.1) {
            SVProgressHUD.show(withStatus:"Waiting...")
            
            AuthService.updateUserInfor(username: usernnameTextField.text!, email: emailTextField.text!, imageData: imageData, onSuccess: {
                SVProgressHUD.showSuccess(withStatus:"Success")
                self.delegate?.updateUserInfor()
            }, onError: { (errorMessage) in
                SVProgressHUD.showError(withStatus:errorMessage)
            })
        }
        
    }
    @IBAction func logoutBtn_TouchUpInside(_ sender: Any) {
        
        AuthService.logout(onSuccess: {
            let storyboard = UIStoryboard(name: "Start", bundle: nil)
            let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
            self.present(signInVC, animated: true, completion: nil)
        }) { (errorMessage) in
            SVProgressHUD.showError(withStatus: errorMessage)
        }
    }
    @IBAction func changeProfileBtn_TouchUpInside(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    }

    
    

extension SettingTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("did Finish Picking Media")
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            profileImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

extension SettingTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return")
        textField.resignFirstResponder()
        return true
    }
}



