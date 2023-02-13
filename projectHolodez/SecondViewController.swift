//
//  SecondViewController.swift
//  projectHolodez
//
//  Created by Дмитрий Абдуллаев on 20.01.2023.
//

import UIKit

class SecondViewController: UIViewController {
    var someText = ""
    
    weak var delegate: ViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func item(_ sender: UIBarButtonItem) {
    let alert =  UIAlertController(title: "select", message: "enter name", preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "save", style: .default) { [self] _ in
    let alertText = alert.textFields?.first?.text
    if alertText?.description.first == someText.description.first {
    delegate.addTableDelegate(addForViewController: alertText ?? "0")
        }
    }
    alert.addTextField()
    alert.addAction(alertAction)
    present(alert, animated: true)
    delegate.tableView.reloadData()
        }
    }
    
    


