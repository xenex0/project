//
//  ViewController.swift
//  projectHolodez
//
//  Created by Дмитрий Абдуллаев on 20.01.2023.
//

import UIKit

protocol ViewControllerProtocol {
  func reloadData()
  func deleteRowsAt(indexes: [IndexPath])
}

class ViewController: UIViewController, ViewControllerProtocol, UITextFieldDelegate {
  @IBOutlet weak var tableView: UITableView!

  var identifier = "identifier"
  var indexPath: IndexPath = []
  let presenter = ViewPresenter()

  override func viewDidLoad() {
    super.viewDidLoad()

    presenter.viewDidLoad()
    presenter.delegate = self
    tableView.delegate = self
    tableView.dataSource = self
  }


  @IBAction func itemBar(_ sender: UIBarButtonItem) {
    let alert =  UIAlertController(title: "select", message: "enter some name",  preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "save", style: .default) { [self] _ in
      let alertText = alert.textFields?.first?.text
      if let alertText = alertText {
        presenter.addNew(item: alertText)
      }
    }
      alert.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
          textField.delegate = self
      })
                         
    alert.addAction(alertAction)
    present(alert, animated: true)
  }

  @IBAction func editItem(_ sender: UIBarButtonItem) {
    tableView.isEditing = !tableView.isEditing
  }

  func reloadData() {
    tableView.reloadData()
  }

  func deleteRowsAt(indexes: [IndexPath]) {
    tableView.deleteRows(at: indexes, with: UITableView.RowAnimation.none)
  }

  func addTableDelegate(addForViewController: String) {
      presenter.itemFor(index: indexPath).name = addForViewController
      presenter.loadSettings()
      tableView.reloadData()
  }
}

 extension ViewController: UITableViewDataSource, UITableViewDelegate {
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return presenter.itemsCount()
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
      let man = presenter.itemFor(index: indexPath)
      cell.textLabel?.text = man.name
      return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      performSegue(withIdentifier: identifier, sender: self)
      self.indexPath = indexPath
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == UITableViewCell.EditingStyle.delete {
      presenter.didRemoveItemAt(index: indexPath)
    }
  }

  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
      presenter.didSwap(
      firstIndex: sourceIndexPath,
      secondIndex: destinationIndexPath
    )
  }

  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "identifier" {
            let addNames = segue.destination as! SecondViewController
            addNames.delegate = self
            addNames.someText =
            presenter.itemFor(index: tableView.indexPathForSelectedRow!).name
            tableView.reloadData()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        let set = NSCharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz").inverted
        return string.rangeOfCharacter(from:set) == nil && newLength <= 1
    }
   
}

