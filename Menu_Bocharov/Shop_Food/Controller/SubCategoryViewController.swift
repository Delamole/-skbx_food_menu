//
//  SubCategoryViewController.swift
//  Menu_Bocharov
//
//  Created by Владислав Бочаров on 17.09.2020.
//  Copyright © 2020 Vladislav Bocharov. All rights reserved.
//

import UIKit

class SubCategoryViewController: UIViewController {
    
    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var nameController: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var subCategoryTable: UITableView!
    
    @IBOutlet weak var nameCategory: UILabel!
    
    var subcategories: [SubCategory] = []
    
    var nameC = ""
    var nameSC = ""
    var id_cat = 0
    var id_shop = 0
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameController.text = nameC
        nameCategory.text = nameSC
        
        view.backgroundColor = .clear
        grayView.alpha = 0.5
        mainView.layer.cornerRadius = 15
        
        LoadModel.shared.loadSubCategory(id_shop: "\(id_shop)", id_cat: "\(id_cat)") { (data) in
            for i in data.data {
                if i.is_category == true {
                self.subcategories.append(i)
                }
                }
            print("data: \(data)")
            self.subCategoryTable.reloadData()
        }
    }
}


extension SubCategoryViewController: UITableViewDataSource, UITableViewDelegate{
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subcategories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "SubCategoryTableViewCell") as! SubCategoryTableViewCell

        cell.initCell(item: subcategories[indexPath.row])
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("item at \(indexPath.section)/\(indexPath.item) tapped")
          let selectedName = subcategories[indexPath.row]
          let newView: ItemViewController = self.storyboard?.instantiateViewController(withIdentifier: "ItemViewController") as! ItemViewController
          newView.nameContr = nameSC
          newView.nameSubCat = selectedName.name
          newView.id_subcat = selectedName.id
          newView.id_shop = id_shop
//        newView.id_cat = id_cat
          present(newView, animated: true, completion: nil)
               
    }
}
