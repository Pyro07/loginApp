//
//  MainPageViewController.swift
//  loginAppV1
//
//  Created by Burak Başeskioğlu on 22.10.2018.
//  Copyright © 2018 Burak Başeskioğlu. All rights reserved.
//
import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import TextFieldEffects

class MainPageViewController: UIViewController, UITextFieldDelegate{

    var activeTextField : UITextField!
    var name = String()
    var email = String()
    var password = String()
    var passwordAgain = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(nameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(passwordTextFieldAgain)
        view.addSubview(enterButton)
        view.addSubview(signInLabel)
        view.addSubview(signInButton)
        setupLayout()
        setupLayout2()
        //setupBottomControls()
        
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordTextFieldAgain.delegate = self
    }
    
    let backgroundImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "Rectangle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
//    let nameTextFieldEffect : TextFieldEffects = {
//       let textField = HoshiTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
//        textField.placeholder = "Enter your name and surname"
//        textField.placeholderColor = .white
//        textField.borderActiveColor = .purple
//        textField.font = UIFont.boldSystemFont(ofSize: 16)
//        textField.placeholderFontScale = 1
//        return textField
//    }()
    
    let nameTextField : UITextField = {
        let text : UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        text.font = UIFont.systemFont(ofSize: 22)
        text.placeholder = "Enter your name and surname"
        text.textAlignment = .center
        text.borderStyle = .roundedRect
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
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
    
    let passwordTextField : UITextField = {
        let text : UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        text.font = UIFont.systemFont(ofSize: 22)
        text.placeholder = "Enter a password"
        text.textAlignment = .center
        text.borderStyle = .roundedRect
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let passwordTextFieldAgain : UITextField = {
        let text : UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        text.font = UIFont.systemFont(ofSize: 22)
        text.placeholder = "Enter password again"
        text.textAlignment = .center
        text.borderStyle = .roundedRect
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let informationLabel : UILabel = {
       let lblInformation = UILabel()
        lblInformation.text = "User Registration"
        lblInformation.textAlignment = .center
        lblInformation.textColor = .white
        lblInformation.font = UIFont.boldSystemFont(ofSize: 30)
        lblInformation.translatesAutoresizingMaskIntoConstraints = false
        return lblInformation
    }()
    
    private let enterButton : UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(userSignUp), for: .touchUpInside)
        return button
    }()
    
    private let signInButton : UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(signInOpen), for: .touchUpInside)
        return button
    }()
    
    let signInLabel : UILabel = {
       let label = UILabel()
        label.text = "or"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @objc func signInOpen(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignIn") as! SignInViewController
        //self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func userSignUp(){
        name = nameTextField.text!
        email = emailTextField.text!
        password = passwordTextField.text!
        passwordAgain = passwordTextFieldAgain.text!
        
        let emailControl = isValidEmail(testStr: email)
        
        if((name.isEmpty) && (email.isEmpty) && (password.isEmpty) && (passwordAgain.isEmpty)){
            let alertView = UIAlertController(title: "Error", message: "Please fill in empty fields", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
        }
        
        else if((self.emailTextField.text?.isEmpty)! || (self.passwordTextField.text?.isEmpty)! || (self.passwordTextFieldAgain.text?.isEmpty)!){
            let alertView = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
        }
        
        else if emailControl == false{
            let alertView = UIAlertController(title: "Error", message: "Please enter a valid email address", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
        }
        
        else if passwordTextField.text != passwordTextFieldAgain.text{
            let alertView = UIAlertController(title: "Error", message: "The passwords you entered do not match each other", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
        }
        
        else{
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){
                (user, error) in
                _ = ["name": self.name, "email": self.email]
                if error == nil {
                    print("You have succesfully signed up")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: true, completion: nil)
                    self.clearTextField()
                }
                else{
                    let alertView = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alertView.addAction(okAction)
                    self.present(alertView, animated: true, completion: nil)
                }
            }
        }
    }
    
    func isValidEmail(testStr: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func clearTextField(){
        nameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        passwordTextFieldAgain.text = ""
    }
    
//    fileprivate func setupBottomControls(){
//        let bottomControlStackView = UIStackView(arrangedSubviews: [enterButton])
//        bottomControlStackView.translatesAutoresizingMaskIntoConstraints = false
//        bottomControlStackView.distribution = .fillEqually
//        view.addSubview(bottomControlStackView)
//        NSLayoutConstraint.activate([
//            bottomControlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            bottomControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            bottomControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            bottomControlStackView.heightAnchor.constraint(equalToConstant: 30)
//            ])
//    }
    
    private func setupLayout(){
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

        nameTextField.topAnchor.constraint(equalTo: frontContainerView.bottomAnchor).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        //nameTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -260).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 7).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        //emailTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -217).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 7).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        //passwordTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -184).isActive = true
        
        passwordTextFieldAgain.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 7).isActive = true
        passwordTextFieldAgain.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        passwordTextFieldAgain.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        //passwordTextFieldAgain.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        
        enterButton.topAnchor.constraint(equalTo: passwordTextFieldAgain.bottomAnchor, constant: 7).isActive = true
        enterButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 90).isActive = true
        enterButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -90).isActive = true
        
        signInLabel.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 11).isActive = true
        signInLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        signInLabel.rightAnchor.constraint(equalTo: signInButton.rightAnchor, constant: -24).isActive = true
        
        signInButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 5).isActive = true
        signInButton.leftAnchor.constraint(equalTo: signInLabel.leftAnchor, constant: 55).isActive = true
        signInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -90).isActive = true
    }
    
    private func setupLayout2(){
        let backgroundImageContainerView = UIView()
        view.addSubview(backgroundImageContainerView)
        backgroundImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageContainerView.addSubview(backgroundImageView)
        
        backgroundImageView.centerXAnchor.constraint(equalTo: backgroundImageContainerView.centerXAnchor).isActive = true
        backgroundImageView.centerYAnchor.constraint(equalTo: backgroundImageContainerView.centerYAnchor).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: backgroundImageContainerView.heightAnchor, multiplier: 1).isActive = true
        //backgroundImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        view.sendSubviewToBack(backgroundImageContainerView)
    }
}
