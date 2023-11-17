//
//  ViewController.swift
//  ExNimber_Testable_MVVM
//
//  Created by VP on 11/17/23.
//

import UIKit

import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .purple
        return tableView
        
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .yellow
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        [tableView, textField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.textField.topAnchor),
            
            textField.topAnchor.constraint(equalTo: self.tableView.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50),
        ])
    
        
    }

}

