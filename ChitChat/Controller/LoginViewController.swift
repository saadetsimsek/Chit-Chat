//
//  ViewController.swift
//  ChitChat
//
//  Created by Saadet Şimşek on 31/07/2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username..."
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: 10,
                                              height: 50))
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .secondarySystemBackground
        return field
    }()

    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "İOS Chat"
        view.backgroundColor = .systemBackground
        
        view.addSubview(usernameField)
        view.addSubview(button)
        addConstraits()
        
        button.addTarget(self,
                         action: #selector(didTapContinue),
                         for: .touchUpInside)
    }
    
    @objc private func didTapContinue(){
        guard let text = usernameField.text, !text.isEmpty else {
            return
        }
        ChatManager.shared.signIn(with: text) {[weak self] success in
            guard success else{
                return
            }
            print("Did login ")
            
            //Take user to chat list
            DispatchQueue.main.async {
                self?.presentChatList()
            }
        }
    }
    
    func presentChatList(animated: Bool = true){
        print("Should show chat list")
        
        guard let vc = ChatManager.shared.createChannelList() else {
            return
        }
        let tabVC = TabBarViewController(chatList: vc)
        tabVC.modalPresentationStyle = .fullScreen
        present(tabVC, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        usernameField.becomeFirstResponder()
        
        if ChatManager.shared.isSignedIn {
            presentChatList(animated: false)
        }
    }
    
  


    private func addConstraits(){
        NSLayoutConstraint.activate([
            usernameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            usernameField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
            usernameField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
            usernameField.heightAnchor.constraint(equalToConstant: 50),
       
        
            button.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20),
            button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

