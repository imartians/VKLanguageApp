//
//  FriendsViewController.swift
//  VKTest
//
//  Created by Daniil Smirnov on 24.10.16.
//  Copyright © 2016 Daniil Smirnov. All rights reserved.
//

import UIKit

let tabBarHeight = 49

class FriendsViewController: UITableViewController {
    
    
    
    var friends = [Friend]()
    var friendsCount: Int?
    var friendsDictionaryArray: [[String: Any]]?
    var parameters = ["user_id": "18545244",
    "order": "name",
//    "offset": 25,
    "fields": ["photo_50", "online"],
    "name_case": "nom"] as [String : Any]
    
//    override func awakeFromNib() {
//        let getFriendsRequest = VKApi.friends().get(parameters)
//        getFriendsRequest?.execute(resultBlock: { (response) in
//            print(response?.json)
//            if let wrapperDictionary = response?.json as! [String : Any]?{
//                if let friendsCountString = wrapperDictionary["count"] as? Int{
//                    self.friendsCount = friendsCountString
//                }
//                self.friendsDictionaryArray = wrapperDictionary["items"] as? [[String: Any]]
//                for friendsDictionary in self.friendsDictionaryArray!{
//                    let friend = Friend()
//                    friend.firstName = friendsDictionary["first_name"] as? String
//                    friend.lastName = friendsDictionary["last_name"] as? String
//                    friend.id = friendsDictionary["id"] as? Int
//                    friend.isOnline = friendsDictionary["online"] as? Int == 0 ? false : true
//                    if friend.isOnline != nil {
//                        friend.isMobile = friendsDictionary["online_mobile"] == nil ? false : true
//                    }
//                    friend.imageUrl = URL(string: friendsDictionary["photo_50"] as! String)
//                    self.friends.append(friend)
//                }
//            }
//            
//            print(self.friends)
//            
//            }, errorBlock: { (error) in
//                print(error)
//        })
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat(-tabBarHeight))
        
        let getFriendsRequest = VKApi.friends().get(parameters)
        getFriendsRequest?.execute(resultBlock: { (response) in
            print(response?.json)
            if let wrapperDictionary = response?.json as! [String : Any]?{
                if let friendsCountString = wrapperDictionary["count"] as? Int{
                    self.friendsCount = friendsCountString
                }
                self.friendsDictionaryArray = wrapperDictionary["items"] as? [[String: Any]]
                for friendsDictionary in self.friendsDictionaryArray!{
                    let friend = Friend()
                    friend.firstName = friendsDictionary["first_name"] as? String
                    friend.lastName = friendsDictionary["last_name"] as? String
                    friend.id = friendsDictionary["id"] as? Int
                    friend.isOnline = friendsDictionary["online"] as? Int == 0 ? false : true
                    if friend.isOnline != nil {
                        friend.isMobile = friendsDictionary["online_mobile"] == nil ? false : true
                    }
                    friend.imageUrl = URL(string: friendsDictionary["photo_50"] as! String)
                    self.friends.append(friend)
                }
            }
            
//            print(self.friends)
            self.tableView.reloadData()
            
            }, errorBlock: { (error) in
                print(error)
        })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return friendsCount!
        return friends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsViewControllerCell", for: indexPath) as! FriendCell
//        print(friends)
        let friend = friends[indexPath.row]
        cell.mobile.isHidden = true
        cell.onlineView.isHidden = true
        cell.name.text = friend.firstName! + " " + friend.lastName!
        downloadImage(url: friend.imageUrl!, cell: cell)
        if friend.isOnline!{
            if friend.isMobile!{
                cell.mobile.isHidden = false
            } else {
                cell.onlineView.isHidden = false
            }
        }
        return cell
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL, cell: FriendCell) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
            
//            cell.imageView?.image = UIImage(data: data)
            cell.photoView.image = UIImage(data: data)
                
            }
        }
    }
 
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
