//
//  HomePageViewController.swift
//  loginAppV1
//
//  Created by Burak Başeskioğlu on 2.11.2018.
//  Copyright © 2018 Burak Başeskioğlu. All rights reserved.
//

import UIKit
import TextFieldEffects
class HomePageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       view.addSubview(textEffect)
       view.addSubview(backButton)
       //view.addSubview(textEffect2)
       //view.addSubview(backButton)
       setupLayout()
       setupLayout2()
       setupBottomControl()
    }
    
    let backgroundView : UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "Rectangle")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let textEffect : UITextField = {
        let textField = HoshiTextField(frame: CGRect(x: 70, y: 269, width: 180, height: 60))
        textField.placeholder = "Adınızı giriniz"
        textField.placeholderColor = .white
        textField.borderInactiveColor = .gray
        textField.borderActiveColor = .purple
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        textField.placeholderFontScale = 1
        return textField
    }()
    
    private let backButton : UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Back MainPage", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backSignInPage), for: .touchUpInside)
        return button
    }()
    
    @objc func backSignInPage(){
        let backVC = self.storyboard?.instantiateViewController(withIdentifier: "SignIn") as! SignInViewController
        //self.navigationController?.pushViewController(backVC, animated: true)
        self.present(backVC, animated: true, completion: nil)
    }
    
//    let textEffect2 : TextFieldEffects = {
//        let textField = HoshiTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
//        textField.placeholder = "Adınızı giriniz"
//        textField.placeholderColor = .white
//        textField.borderInactiveColor = .gray
//        textField.borderActiveColor = .purple
//
//        textField.font = UIFont.boldSystemFont(ofSize: 16)
//        textField.placeholderFontScale = 1
//        return textField
//    }()
    
    let lblText : UILabel = {
       let label = UILabel()
        label.text = "Deneme"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func setupBottomControl(){
        let bottomControlStackView = UIStackView(arrangedSubviews: [backButton])
        bottomControlStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlStackView.distribution = .equalSpacing
        bottomControlStackView.axis = .vertical
        view.addSubview(bottomControlStackView)
        NSLayoutConstraint.activate([
            bottomControlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            bottomControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 80),
            bottomControlStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -80),
            bottomControlStackView.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    private func setupLayout(){
        let container = UIView()
        view.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        container.addSubview(backgroundView)
        
        backgroundView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 1).isActive = true
        view.sendSubviewToBack(container)
    }
    
    private func setupLayout2(){
        let containerView = UIView()
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: -60).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.addSubview(lblText)
        containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        lblText.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        lblText.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        lblText.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5).isActive = true
        
//        textEffect.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        textEffect.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        textEffect.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        
        textEffect.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 80).isActive = true
        textEffect.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        textEffect.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        //textEffect.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -260).isActive = true
        
        backButton.topAnchor.constraint(equalTo: textEffect.bottomAnchor, constant: 80).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        backButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        
        //textEffect2.topAnchor.constraint(equalTo: textEffect.bottomAnchor, constant: 40).isActive = true
        //textEffect2.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        //textEffect2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        
//        backButton.topAnchor.constraint(equalTo: textEffect.bottomAnchor).isActive = true
//        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 90).isActive = true
//        backButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -90).isActive = true
    }
}
