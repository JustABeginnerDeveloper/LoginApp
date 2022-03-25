//
//  ViewController.swift
//  LoginApp
//
//  Created by Gregory Odintsov on 25.03.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    private let user = "user"
    private let password = "password"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let welcomeVC = segue.destination as! WelcomeViewController
        welcomeVC.user = user
    }
    
    @IBAction func loginPressed() {
        if userNameTF.text != user || passwordTF.text != password {
            showAlert(
                with: "Invalid login or password",
                message: "Please, enter correct login and password",
                textfield: passwordTF
            )
            return
        }
        performSegue(withIdentifier: "ShowWelcomeVC", sender: nil)
    }
    @IBAction func forgotRegisterData(_ sender: UIButton) {
        sender.tag == 0
        ? showAlert(with: "Ooops!", message: "Your name is \(user) 😉")
        : showAlert(with: "Ooops!", message: "Your password is \(password) 😉")
    }
    
    @IBAction func unwindSegue(for: UIStoryboardSegue) {
        userNameTF.text = nil
        passwordTF.text = nil
    }
}

extension LoginViewController {
    private func showAlert(with title: String, message: String, textfield: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textfield?.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTF {
            passwordTF.becomeFirstResponder()
        } else {
            loginPressed()
        }
        return true
    }
}
