//
//  FavoritesViewController.swift
//  ConnectionsTask
//
//  Created by Venkatarao Ponnapalli  on 20/02/21.
//  Copyright © 2021 Venkatarao Ponnapalli . All rights reserved.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
     var favoriteArray : [Post] = []
    @IBOutlet weak var favoriteTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        retrieveSavedfavorites()
        self.navigationController?.title = "Favorites"
        
    }
    func retrieveSavedfavorites() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        request.returnsObjectsAsFaults = false
        var retrievedUsers: [Post] = []
        do {
            let results = try context.fetch(request)
            if !results.isEmpty {
                for result in results as! [NSManagedObject] {
                    let id = result.value(forKey: "id") as? Int
                     let title = result.value(forKey: "title") as? String
                    let body = result.value(forKey: "body") as? String
                    let user = Post(userID: id ?? -1, id: id ?? -1, title: title ?? "", body: body ?? "")
                    retrievedUsers.append(user)
                }
            }
            favoriteArray = retrievedUsers
            DispatchQueue.main.async{
                self.favoriteTableview.reloadData()
            }
            print(favoriteArray)
        } catch {
            print("Error retrieving: \(error)")
        }
    }
    // MARK: - TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavoriteTableViewCell
        cell.id_lbl.text = String(favoriteArray[indexPath.row].userID)
        cell.titile_lbl.text = favoriteArray[indexPath.row].title
        cell.body_lbl.text =  favoriteArray[indexPath.row].body
        return cell
    }
    
}


