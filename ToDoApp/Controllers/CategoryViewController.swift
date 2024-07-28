//
//  CategoryViewController.swift
//  ToDoApp
//
//  Created by Sergey Zakurakin on 27/07/2024.
//

import UIKit
import CoreData

final class CategoryViewController: UIViewController {
    
    
    //MARK: - Private properties
    private var categories = ["55", "aa", "76"]
    
    
    //MARK: - UI
    private let tableView = UITableView()
    

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraint()
        delegates()
    }
    
    
    private func delegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - setup View
    private func setupView() {
        view.backgroundColor = .cyan
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Category")
        
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        
        
        navigationItem.rightBarButtonItem = addButton
        title = "Category"
    }
    
    //MARK: - Actions
    
    @objc func addButtonTapped() {
        print("add")
    }
    
    
}


//MARK: - Setup Constraint
extension CategoryViewController {
    
    func setupConstraint() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

        
        ])
    }
}



    // MARK: - Table view data source, and delegate
extension CategoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Category", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row]
        
        return cell
    }
  
}


