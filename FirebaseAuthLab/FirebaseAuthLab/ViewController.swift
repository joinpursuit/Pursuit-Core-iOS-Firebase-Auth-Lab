//
//  ViewController.swift
//  FirebaseAuthLab
//
//  Created by Ahad Islam on 3/12/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit

enum AccountState {
    case existingUser
    case newUser
}

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var weakLabel: UILabel!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var accountState: AccountState = .newUser
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else {
                errorLabel.text = "Fields are empty."
                errorLabel.isHidden = false
                return
        }
        
        userFlow(email, password: password)
    }
    
    @IBAction func changeButtonPressed(_ sender: UIButton) {
        
        accountState = accountState == .newUser ? .existingUser : .newUser
        switch accountState {
        case .existingUser:
            signButton.setTitle("Login", for: .normal)
            weakLabel.text = "No account?"
            changeButton.setTitle("SIGNUP", for: .normal)
        case .newUser:
            signButton.setTitle("Signup", for: .normal)
            weakLabel.text = "Already account?"
            changeButton.setTitle("LOGIN", for: .normal)
        }
        
    }
    
    private func userFlow(_ email: String, password: String) {
        
        if accountState == .newUser {
        AuthSession.current.createNewUser(email, password: password) { [weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorLabel.text = error.localizedDescription
                    self?.errorLabel.isHidden = false
                }
            case .success(let result):
                print(result.description)
                UIViewController.showViewController(from: "Profile", id: "profileVC")
            }
        }
        } else {
            AuthSession.current.signExistingUser(email, password: password) { [weak self] result in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.errorLabel.text = error.localizedDescription
                        self?.errorLabel.isHidden = false
                    }
                case .success(let result):
                    print(result.description)
                    UIViewController.showViewController(from: "Profile", id: "profileVC")
                }
            }
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
