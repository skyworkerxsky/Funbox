//
//  BackEnd_TableViewController.swift
//  FunboxStore
//
//  Created by Алексей Макаров on 20.01.2020.
//  Copyright © 2020 Алексей Макаров. All rights reserved.
//

import UIKit
import RealmSwift


@IBDesignable class BackEndTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    let device = try! Realm().objects(DeviceModel.self)
    let hasLaunchedKey = "HasLaunched"
    let defaults = UserDefaults.standard
    
    // MARK: - Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(prep))
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        
        let hasLaunched = defaults.bool(forKey: hasLaunchedKey)
        if !hasLaunched {
            defaults.set(true, forKey: hasLaunchedKey)
            let device = DeviceModel()
            device.createTest()
        }
    }
    
    // MARK: - Selectors
    
    @objc func prep() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: String(describing: DetailTableViewController.self)) as! DetailTableViewController
        let nav = UINavigationController(rootViewController: nextViewController)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated:true, completion:nil)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return device.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.textLabel?.text = device[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = device[indexPath.row]
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: String(describing: DetailTableViewController.self)) as! DetailTableViewController
        let nav = UINavigationController(rootViewController: nextViewController)
        nextViewController.currentDevice = device[indexPath.row]
        self.present(nav, animated:true, completion:nil)
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail" {
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let newDevice = device[indexPath.row]
            let newDeviceVC = segue.destination as! DetailTableViewController
            newDeviceVC.currentDevice = newDevice
            
        }
    }
    
    // MARK: - Actions
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newDeviceVC = segue.source as? DetailTableViewController else { return }
        
        newDeviceVC.saveDevice()
        tableView.reloadData()
    }
    
}
