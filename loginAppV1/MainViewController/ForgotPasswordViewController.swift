//
//  ForgotPasswordViewController.swift
//  loginAppV1
//
//  Created by Burak Başeskioğlu on 24.10.2018.
//  Copyright © 2018 Burak Başeskioğlu. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(emailTextField)
        view.addSubview(enterButton)
        view.addSubview(backButton)
        setupLayout()
        setupLayout2()
    }
    
    let backgroundImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "Rectangle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let emailTextField : UITextField = {
        let text : UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        text.font = UIFont.systemFont(ofSize: 22)
        text.placeholder = "Enter your email address"
        text.textAlignment = .center
        text.borderStyle = .roundedRect
        text.keyboardType = .emailAddress
        text.autocapitalizationType = .none
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let informationLabel : UILabel = {
       let label = UILabel()
        label.text = "Forgot Password"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let enterButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
        return button
    }()
    
    private let backButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backPage), for: .touchUpInside)
        return button
    }()
    
    @objc func backPage(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignIn") as! SignInViewController
        //self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func resetPassword(){
        if emailTextField.text! == "" {
            let alertView = UIAlertController(title: "Opps!", message: "Please enter an email", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
        }
        else{
            Auth.auth().sendPasswordReset(withEmail: self.emailTextField.text!, completion: {
                error in
                var title = ""
                var message = ""
                if error != nil{
                    title = "Error!"
                    message = (error?.localizedDescription)!
                }
                else{
                    title = "Success!"
                    message = "Password reset email sent"
                    self.emailTextField.text! = ""
                }
                let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alertView.addAction(okAction)
                self.present(alertView, animated: true, completion: nil)
            })
        }
    }
    
    private func setupLayout(){
        let backgroundImageViewContainer = UIView()
        view.addSubview(backgroundImageViewContainer)
        backgroundImageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageViewContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageViewContainer.addSubview(backgroundImageView)
        
        backgroundImageView.centerXAnchor.constraint(equalTo: backgroundImageViewContainer.centerXAnchor).isActive = true
        backgroundImageView.centerYAnchor.constraint(equalTo: backgroundImageViewContainer.centerYAnchor).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: backgroundImageViewContainer.heightAnchor, multiplier: 1).isActive = true
        view.sendSubviewToBack(backgroundImageViewContainer)
    }
    
    private func setupLayout2(){
        let frontContainerView = UIView()
        view.addSubview(frontContainerView)
        frontContainerView.translatesAutoresizingMaskIntoConstraints = false
        frontContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: -60).isActive = true
        frontContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        frontContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        frontContainerView.addSubview(informationLabel)
        frontContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        informationLabel.centerXAnchor.constraint(equalTo: frontContainerView.centerXAnchor).isActive = true
        informationLabel.centerYAnchor.constraint(equalTo: frontContainerView.centerYAnchor).isActive = true
        informationLabel.heightAnchor.constraint(equalTo: frontContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: frontContainerView.bottomAnchor, constant: 50).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        //emailTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300).isActive = true
        
        enterButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10).isActive = true
        enterButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 90).isActive = true
        enterButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -90).isActive = true
        
        backButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 20).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        backButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
    }
}
