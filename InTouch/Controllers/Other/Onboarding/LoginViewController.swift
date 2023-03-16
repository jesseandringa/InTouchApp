//
//  LoginViewController.swift
//  InTouch
//
//  Created by jesse andringa on 3/8/23.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
    struct Constants{
        static let cornerRadius = 8.0
    }
    ////These are called anonymous closures
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "UserName or email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms and Conditions", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal )
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Privacy Policy", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
        
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("New User? Create an Account", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        
        return button
    }()
    
    private let headerView: UIView = {
        let h = UIView()
        h.clipsToBounds = true
        let backGroundImageView = UIImageView(image: UIImage(named: "gradient"))
        h.addSubview(backGroundImageView)
        return h
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //add when button clicked events
        loginButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(tapPrivacyButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(tapTermsButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(tapCreateAccountButton), for: .touchUpInside)
        
        //add subviews to page
        addSubViews()
        
        view.backgroundColor = .systemBackground
        
        usernameEmailField.delegate = self
        passwordField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //assign frames
        headerView.frame = CGRect(
          x: 0,
          y: 0.0, //view.safeAreaInsets.top
          width: view.width,
          height: view.height/3.0)
        
        usernameEmailField.frame = CGRect(
          x: 25,
          y: headerView.bottom + 40, //view.safeAreaInsets.top
          width: view.width - 50 ,
          height: 52.0)
        
        passwordField.frame = CGRect(
          x: 25,
          y: usernameEmailField.bottom + 10, //view.safeAreaInsets.top
          width: view.width - 50 ,
          height: 52.0)
        
        loginButton.frame = CGRect(
          x: 25,
          y: passwordField.bottom + 10, //view.safeAreaInsets.top
          width: view.width - 50 ,
          height: 52.0)
        createAccountButton.frame = CGRect(
          x: 25,
          y: loginButton.bottom + 10, //view.safeAreaInsets.top
          width: view.width - 50 ,
          height: 52.0)
        
        termsButton.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 100,
            width: view.width - 20.0,
            height: 50)
        privacyButton.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 50,
            width: view.width - 20,
            height: 50)
    }
    
    private func configureHeaderView(){
        guard headerView.subviews.count == 1 else{
            return
        }
        guard let backgroundView = headerView.subviews.first else{
            return
        }
        backgroundView.frame = headerView.bounds
        
        //add logo
        let logoView = UIImageView(image: UIImage(named: "logoText"))
        headerView.addSubview(logoView)
        logoView.contentMode = .scaleAspectFit
        logoView.frame = CGRect(
            x: headerView.width/4.0,
            y: view.safeAreaInsets.top,
            width: headerView.width/2.0,
            height: headerView.height - view.safeAreaInsets.top)
    }
    
    private func addSubViews(){
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
    }
    
    @objc private func tapLoginButton(){
        //switch off keyboard
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        
        //set text to fields and guard them
        guard let userNameText = usernameEmailField.text, !userNameText.isEmpty,
              let passwordText = passwordField.text, !passwordText.isEmpty, passwordText.count >= 8 else {
                  return
              }
        var email: String?
        var username: String?
        
        if userNameText.contains("@"), userNameText.contains("."){
         email = userNameText
        }
        else{
            username = userNameText
        }
        AuthManager.shared.loginUser(userName: username, email: email, password: passwordText){ success in
            DispatchQueue.main.async {
                if success {
                    print("logged in successfully")
                    self.dismiss(animated: true, completion: nil)
                }
                else{
                    let alert = UIAlertController(title: "log in error",
                                                  message: "unable to log in",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss",
                                                  style: .cancel,
                                                  handler: nil))
                    self.present(alert,animated: true)
                    //error
                }
            }
            
        }
        //login functionality
    }
    
    @objc private func tapTermsButton(){
        guard let url = URL(string:"https://help.instagram.com/581066165581870") else{
            return
        }
        let vc = SFSafariViewController(url:url)
        present(vc, animated: true)
    }
    
    @objc private func tapPrivacyButton(){
        guard let url = URL(string:"https://privacycenter.instagram.com/policy") else{
            return
        }
        let vc = SFSafariViewController(url:url)
        present(vc, animated: true)
    }
    
    @objc private func tapCreateAccountButton(){
        let vc = SignUpViewController()
        vc.title = "Create Account"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}

extension LoginViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField == usernameEmailField){
            passwordField.becomeFirstResponder()
        }
        if(textField == passwordField){
            tapLoginButton()
        }
        return true
    }
}
