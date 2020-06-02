//
//  ResultViewController.swift
//  Authorization
//
//  Created by Elena Kacharmina on 02.06.2020.
//  Copyright © 2020 Elena Kacharmina. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var resultDict: [String: Any]?
    
    var loginLabel: UILabel!
    var idLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setData()
    }
    
    private func setData() {
        guard let resultDict = resultDict else { return }
        if let login = resultDict["login"] {
            loginLabel.text = "Login: \(login)"
        }
        if let id = resultDict["id"] {
            idLabel.text = "Id: \(id)"
        }
    }
    
    private func setupUI() {
        
        view.backgroundColor = .white
        loginLabel = UILabel()
        loginLabel.text = "Login: "
        idLabel = UILabel()
        idLabel.text = "Id: "
        
        view.addSubview(loginLabel)
        view.addSubview(idLabel)
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            
            idLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            idLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 50),
            
        ])
    }

}
