//
//  ViewController.swift
//  Authorization
//
//  Created by Elena Kacharmina on 02.06.2020.
//  Copyright © 2020 Elena Kacharmina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var loginTextField: UITextField!
    var passwordTextField: UITextField!
    
    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        loginTextField = UITextField()
        loginTextField.placeholder = "login"
        loginTextField.borderStyle = .roundedRect
        
        passwordTextField = UITextField()
        passwordTextField.placeholder = "password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.textContentType = .password
        
        button = UIButton(type: .system)
        button.setTitle("Авторизоваться", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(authTapped), for: .touchUpInside)
        
        [loginTextField,
         passwordTextField,
         button].forEach {
            view.addSubview($0)
        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            loginTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loginTextField.widthAnchor.constraint(equalToConstant: 200),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 30),
            passwordTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 200),
            
            button.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func authTapped(_ sender: UIButton) {
        guard let login = loginTextField.text, let password = passwordTextField.text else {
            showAlert()
            return
        }
        postRequest(username: login, password: password)
    }
    
    func postRequest(username: String, password: String) {
        
        let authParameters = [
            "username": username,
            "password": password
            ] as [String: Any]
        guard let parameters = try? JSONSerialization.data(withJSONObject: authParameters, options: []) else {
            return
        }
        
        let url = URL(string: "http://37.140.199.187:3000/auth/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = parameters
        
        let session = URLSession.shared
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { [weak self] data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    DispatchQueue.main.async {
                        let nextViewController = ResultViewController()
                        nextViewController.resultDict = json
                        self?.present(nextViewController, animated: true, completion: nil)
                    }
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

