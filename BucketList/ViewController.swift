//
//  ViewController.swift
//  BucketList
//
//  Created by Martin Richter on 11.11.22.
//

import UIKit

class ViewController: UIViewController {
    
  @IBOutlet weak var myTableView: UITableView!
    
  var editable = false
  var besuchteOrte = ["Venezuela", "Kenia"]
  var neueZiele: [String] = []
    
  override func viewDidLoad() {
    super.viewDidLoad()
    myTableView.delegate = self
    myTableView.dataSource = self
  }
    
  @IBOutlet weak var editBtn: UIBarButtonItem!
    
  @IBAction func addItem(_ sender: Any) {
    let alert = UIAlertController(title: "Hinzufügen", message: "Welche Orte willst du besuchen", preferredStyle: .alert)
      
    alert.addTextField()
    alert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel))
    alert.addAction(UIAlertAction(title: "Hinzufügen", style: .default, handler: {(_) in
      let text = alert.textFields?.first?.text
      self.besuchteOrte.append(text!)
      self.myTableView.reloadData()
    }))
    present(alert, animated: true)
  }
    
  @IBAction func edittrue(_ sender: UIBarButtonItem) {
    self.myTableView.isEditing = !self.myTableView.isEditing
    sender.title = (self.myTableView.isEditing) ? "Done" : "Edit"
  }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
    
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
    if (section == 0){
      return "Orte zum Besuchen"
    }else {
      return "Besuchte Orte"
    }
  }
    
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath ) {
      let data = besuchteOrte[sourceIndexPath.item]
      besuchteOrte.remove (at: sourceIndexPath.item)
      besuchteOrte.insert (data, at: destinationIndexPath.item)
  }
    
  func tableView(_ tableView: UITableView,canEditRowAt indexPath: IndexPath) -> Bool{
    return true
  }
    
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if(section == 0) {
      return besuchteOrte.count
    } else {
      return neueZiele.count
    }
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = myTableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
    if indexPath.section == 0 {
      var content = cell.defaultContentConfiguration()
      content.text = besuchteOrte[indexPath.row]
      cell.contentConfiguration = content
      cell.accessoryType = .none
    } else {
      if indexPath.section == 1 {
        var content = cell.defaultContentConfiguration()
        content.text = neueZiele[indexPath.row]
        cell.contentConfiguration = content
        cell.accessoryType = .checkmark
      }
    }
    return cell
  }
    
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if(editingStyle == .delete){
      if(indexPath.section == 0){
        besuchteOrte.remove(at: indexPath.row)
        myTableView.deleteRows(at: [indexPath], with: .fade)
      } else {
        neueZiele.remove(at: indexPath.row)
        myTableView.deleteRows(at: [indexPath], with: .fade)
      }
    }
  }
    
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    myTableView.deselectRow(at: indexPath, animated: true)
    if (indexPath.section) == 0{
      let data = besuchteOrte[indexPath.row]
      neueZiele.append(data)
      besuchteOrte.remove(at: indexPath.row)
    }
    if (indexPath.section) == 1{
      let data = neueZiele[indexPath.row]
      besuchteOrte.append(data)
      neueZiele.remove(at: indexPath.row)
    }
    myTableView.reloadData()
  }
}

