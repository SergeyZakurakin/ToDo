//
//  ViewController.swift
//  ToDoApp
//
//  Created by Sergey Zakurakin on 23/07/2024.
//

import UIKit
import CoreData

final class ViewController: UIViewController {
    
    
    
    
    
    //MARK: - Private properties
    
    private var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        
    
    //MARK: - Setup UI
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    
    

    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let dataFilePath = FileManager.default.urls(for: documentDirectory, in: userDomainMask).first?.appendingPathComponent("Item.plist")
        
        
        
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
        view.addSubview(searchBar)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "toDoItemCell")
        
        loadItems()
    }
    
    
    //MARK: - Delegates
    private func delegates() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        searchBar.delegate = self
    }
    
    //MARK: - Actions
    
    @objc func addButtonTapped() {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { [weak self] action in
            
            guard let self else { return }
            // what will happen when User click to Add Item "ToDoListArray"
                    
            
            let newItem = Item(context: context)
            newItem.title = textField.text!
            newItem.done = false
            itemArray.append(newItem)
            
            saveItems()
            
            
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
    //MARK: - private Methods
    private func saveItems() {
        
        do {
            
            try context.save()
        } catch {
            print("error saving context \(error)")
            
        }
        tableView.reloadData()
    }
    
    
    private func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fecthing data from context \(error)")
        }
    }
    
}


//MARK: - Setup Constarints
extension ViewController {
    
    
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UISearchBar methods
extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]

        loadItems(with: request)
        
        print(searchBar.text!)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}


