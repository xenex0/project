//
//  Presenter.swift
//  projectHolodez
//
//  Created by Дмитрий Абдуллаев on 20.01.2023.
//

import Foundation

protocol NameControllerPresenter: AnyObject {
  func viewDidLoad()
  func itemsCount() -> Int
  func itemFor(index: IndexPath) -> Man
  func didRemoveItemAt(index: IndexPath)
  func didSwap(firstIndex: IndexPath, secondIndex: IndexPath)
  func addNew(item: String)
}

class ViewPresenter: NameControllerPresenter {
    
  var array: [Man] = []
  private let userDefaults = UserDefaults.standard
  private let nameKey = "nameKey"
  var delegate: ViewControllerProtocol?
        
  func viewDidLoad() {
   
  if let savedPeople = userDefaults.object(forKey: "array") as? Data {
  if let decodedPeople = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople) as? [Man] {
        array = decodedPeople
        }
      }
    }
        
 func itemsCount() -> Int {
        array.count
    }
        
 func itemFor(index: IndexPath) -> Man {
        array[index.row]
    }
        
 func didRemoveItemAt(index: IndexPath) {
        array.remove(at: index.row)
        loadSettings()
        delegate?.deleteRowsAt(indexes: [index])
    }
        
 func didSwap(firstIndex: IndexPath, secondIndex: IndexPath) {
        array.swapAt(firstIndex.row, secondIndex.row)
        loadSettings()
    }
        
 func addNew(item: String) {
        array.append(.init(name: item))
        loadSettings()
        delegate?.reloadData()
    }
    
    private func loadData() {
        if let savedPeople = userDefaults.object(forKey: "array") as? Data {
        if let decodedPeople = try?   NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople) as? [Man] {
            array = decodedPeople
            }
        }
    }
        
   func loadSettings() {
    if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: false) {
        userDefaults.set(savedData, forKey: "array")
         }
       }
     }


    

