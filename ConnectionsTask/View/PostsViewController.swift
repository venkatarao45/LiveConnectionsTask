//
//  PostsViewController.swift
//  ConnectionsTask
//
//  Created by Venkatarao Ponnapalli  on 20/02/21.
//  Copyright © 2021 Venkatarao Ponnapalli . All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class PostsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var postTableview: UITableView!
var postsArr : [Post] = []
var totalArray : [Post] = []

    var faviritArray : [Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Connectivity.isConnectedToInternet() {
              AF.request("https://jsonplaceholder.typicode.com/posts")
               .validate()
               .responseDecodable(of: [Post].self) { (response) in
                 guard let postsArr = response.value else { return }
                   self.totalArray = postsArr
                self.savePostsData(postsArr)
                   DispatchQueue.main.async{
                       self.postTableview.reloadData()
                   }
                   
               }
        }
        else{
            self.retrieveSavedPostes()
        }
        
        
    }
    // MARK: - TableView DataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomeTableViewCell
        cell.id_lbl.text = String(totalArray[indexPath.row].userID)
        cell.title_lbl.text = totalArray[indexPath.row].title
        cell.body_lbl.text =  totalArray[indexPath.row].body
        cell.favorts_btn.addTarget(self, action:#selector(self.buttonTapped(sender:)), for: .touchUpInside)
        cell.favorts_btn.tag = indexPath.row
    
        return cell
    }
    @objc func buttonTapped(sender:UIButton){
        
        if sender.isSelected {
            sender.isSelected = false
            if faviritArray.count > 0 {
                faviritArray.remove(at: sender.tag)
            }
        }
        else{
            sender.isSelected = true
            if totalArray.count > 0 {
                faviritArray.append(totalArray[sender.tag])
                self.saveFavoritesData(faviritArray)
            }
        }
        self.postTableview.reloadData()
    }
    // Save the Favorites Data
    func saveFavoritesData(_ posts: [Post]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        let context = appDelegate.persistentContainer.viewContext
        for post in posts {
           let favorites = NSEntityDescription.insertNewObject(forEntityName: "Favorites", into: context)
            favorites.setValue(post.id, forKey: "id")
            favorites.setValue(post.title, forKey: "title")
            favorites.setValue(post.body, forKey: "body")
        }
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error saving: \(error)")
        }
    }
    // save the Posts Data to Coredata
    func savePostsData(_ posts: [Post]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        let context = appDelegate.persistentContainer.viewContext
        for post in posts {
           let postslist = NSEntityDescription.insertNewObject(forEntityName: "Posts", into: context)
            postslist.setValue(post.id, forKey: "id")
            postslist.setValue(post.title, forKey: "title")
            postslist.setValue(post.body, forKey: "body")
        }
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error saving: \(error)")
        }
    }
    // retevie tha Data from CoreData
    func retrieveSavedPostes() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Posts")
        request.returnsObjectsAsFaults = false
        var retrievedPosts: [Post] = []
        do {
            let results = try context.fetch(request)
            if !results.isEmpty {
                for result in results as! [NSManagedObject] {
                    let id = result.value(forKey: "id") as? Int
                     let title = result.value(forKey: "title") as? String
                    let body = result.value(forKey: "body") as? String
                    let user = Post(userID: id ?? -1, id: id ?? -1, title: title ?? "", body: body ?? "")
                    retrievedPosts.append(user)
                }
            }
            totalArray .removeAll()
            if retrievedPosts.count > 0 {
                totalArray = retrievedPosts
            }
            DispatchQueue.main.async{
                self.postTableview.reloadData()
            }
        } catch {
            print("Error retrieving: \(error)")
        }
    }
}
class Connectivity {
class func isConnectedToInternet() -> Bool {
    return NetworkReachabilityManager()?.isReachable ?? false
}
}
