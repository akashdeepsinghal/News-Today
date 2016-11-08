//
//  ViewController.swift
//  News
//
//  Created by Akash Singhal on 03/11/16.
//  Copyright © 2016 Akash Singhal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var heading: UILabel!
    @IBOutlet var newsTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request("https://webhose.io/search?token=563a1d2b-8de6-43e6-ba42-c924761cfd28&format=json&language=english").responseJSON{response in
            if let NewsJSON = response.result.value as AnyObject? {
                //print(JSON)
                
                let posts = JSON(NewsJSON)["posts"].arrayValue
                //print(posts[0]["uuid"])
                
                //print(posts[0]["text"])
                
                let NewsTitles =  posts.map({$0["title"].stringValue})
                let NewsDetails =  posts.map({$0["text"].stringValue})
                
                print(NewsTitles)
                
                func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                    return posts.count
                }
                
                func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                    let cell = self.newsTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!
                    CustomCell
                    
                    cell.title.text = NewsTitles[indexPath.row]
                    cell.newsText.text = NewsDetails[indexPath.row]
                    
                    return cell
                }
                
            }
            

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.newsTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!
        CustomCell
        
        cell.title.text = "Todays News"
        cell.newsText.text = "Blah Blah"
        
        return cell
    }
    
}
