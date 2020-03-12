//
//  ProfileViewController.swift
//  FirebaseAuthLab
//
//  Created by Ahad Islam on 3/12/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func updateButton(_ sender: UIButton) {
        guard let request = Auth.auth().currentUser?.createProfileChangeRequest() else {
            return
        }
        
        request.displayName = nameTextField.text
        request.commitChanges { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    @IBAction func signOut(_ sender: UIButton) {
        try? Auth.auth().signOut()
        UIViewController.showViewController(from: "Login", id: "loginVC")

    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
        Auth.auth().currentUser?.delete(completion: nil)
        UIViewController.showViewController(from: "Login", id: "loginVC")
    }
    
    private func loadData() {
        if let user = Auth.auth().currentUser {
            nameTextField.text = user.displayName
            numberTextField.text = user.phoneNumber
            emailTextField.text = user.email
        }
    }
    
    

}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
