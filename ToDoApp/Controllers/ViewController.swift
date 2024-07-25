//
//  ViewController.swift
//  ToDoApp
//
//  Created by Sergey Zakurakin on 23/07/2024.
//

import UIKit

final class ViewController: UIViewController {
    
    //MARK: - Private properties
    
    private var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    
    //MARK: - Setup UI
    private let tableView = UITableView()

    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        delegates()
        
    }
    
    
    //MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .cyan
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        
        
        navigationItem.rightBarButtonItem = addButton
        title = "TO DO"
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "toDoItemCell")
        
        
        let newItem = Item()
        newItem.title = "Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Jack"
        itemArray.append(newItem3)
    }
    
    
    //MARK: - Delegates
    private func delegates() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    //MARK: - Actions
    
    @objc func addButtonTapped() {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { [weak self] action in
            
            guard let self else { return }
            // what will happen when User click to Add Item "ToDoListArray"
            
            let newItem = Item()
            newItem.title = textField.text!
            itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            tableView.reloadData()
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
    
}


//MARK: - Setup Constarints
extension ViewController {
    
    
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        
        ])
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
  
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        
//        let model = itemArray[indexPath.row]
//        cell.configure(model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
}



