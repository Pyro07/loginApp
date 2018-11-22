//
//  SignInViewController.swift
//  loginAppV1
//
//  Created by Burak Başeskioğlu on 27.10.2018.
//  Copyright © 2018 Burak Başeskioğlu. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {

    var email = String()
    var password = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(forgotPasswordButton)
        //view.addSubview(mainPageButton)
        
        containerLayout()
        backgroundSetupLayout()
        setupBottomControls()
    }
    
    let backgroundImage : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Rectangle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let informationLabel : UILabel = {
       let label = UILabel()
        label.text = "User Login"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailTextField : UITextField = {
        let textField : UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 80))
        textField.font = UIFont.systemFont(ofSize: 22)
        textField.placeholder = "Enter your email"
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField : UITextField = {
        let textField : UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 80))
        textField.font = UIFont.systemFont(ofSize: 22)
        textField.placeholder = "Enter your password"
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let signInButton : UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 26)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(userSignIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let forgotPasswordButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(forgotPasswordOpen), for: .touchUpInside)
        return button
    }()
    
    @objc func forgotPasswordOpen(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "forgotPassword") as! ForgotPasswordViewController
        //self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
    
    private let mainPageButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up Page Back", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(mainPageBack), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func mainPageBack(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainPage") as! MainPageViewController
        //self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func userSignIn(){
        email = emailTextField.text!
        password = passwordTextField.text!
        let emailControl = isValidEmail(testStr: email)
        if((email.isEmpty) || (password.isEmpty)){
            let alertView = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alertView.addAction(okAction)
            present(alertView, animated: true, completion: nil)
        }
        else if emailControl == false{
            let alertView = UIAlertController(title: "Error", message: "Lütfen geçerli bir email adresi giriniz", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alertView.addAction(okAction)
            present(alertView, animated: true, completion: nil)
        }
        else{
            Auth.auth().signIn(withEmail: email, password: password){
                (user, error) in
                if error == nil{
                    print("You have successfully loggen in")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    self.present(vc!, animated: true, completion: nil)
                }
                else{
                    let alertView = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
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
    
    fileprivate func setupBottomControls(){
        let bottomControlStackView = UIStackView(arrangedSubviews: [forgotPasswordButton, mainPageButton])
        bottomControlStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlStackView.distribution = .equalSpacing
        bottomControlStackView.axis = .vertical
        bottomControlStackView.spacing = 5
        view.addSubview(bottomControlStackView)
        NSLayoutConstraint.activate([
            bottomControlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            bottomControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 80),
            bottomControlStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -80),
            bottomControlStackView.heightAnchor.constraint(equalToConstant: 70)
            ])
    }
    
    private func containerLayout(){
        let containerViewLayout = UIView()
        view.addSubview(containerViewLayout)
        containerViewLayout.translatesAutoresizingMaskIntoConstraints = false
        containerViewLayout.topAnchor.constraint(equalTo: view.topAnchor, constant: -60).isActive = true
        containerViewLayout.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerViewLayout.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerViewLayout.addSubview(informationLabel)
        containerViewLayout.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        informationLabel.centerXAnchor.constraint(equalTo: containerViewLayout.centerXAnchor).isActive = true
        informationLabel.centerYAnchor.constraint(equalTo: containerViewLayout.centerYAnchor).isActive = true
        informationLabel.heightAnchor.constraint(equalTo: containerViewLayout.heightAnchor, multiplier: 0.5).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: containerViewLayout.bottomAnchor, constant: 25).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        //emailTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        
        signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
        signInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 90).isActive = true
        signInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -90).isActive = true
        
//        forgotPasswordButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 165).isActive = true
//        forgotPasswordButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 80).isActive = true
//        forgotPasswordButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -80).isActive = true
//
//        mainPageButton.topAnchor.constraint(equalTo: forgotPasswordButton.topAnchor, constant: -30).isActive = true
//        mainPageButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
//        mainPageButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
    }
    
    private func backgroundSetupLayout(){
        let backgroundImageViewContainer = UIView()
        view.addSubview(backgroundImageViewContainer)
        backgroundImageViewContainer.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageViewContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageViewContainer.addSubview(backgroundImage)
        
        backgroundImage.centerXAnchor.constraint(equalTo: backgroundImageViewContainer.centerXAnchor).isActive = true
        backgroundImage.centerYAnchor.constraint(equalTo: backgroundImageViewContainer.centerYAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalTo: backgroundImageViewContainer.heightAnchor, multiplier: 1).isActive = true
        view.sendSubviewToBack(backgroundImageViewContainer)
    }
}
