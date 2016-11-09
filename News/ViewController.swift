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
import SVProgressHUD

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var heading: UILabel!
    @IBOutlet var newsTable: UITableView!
    var arrRes = [[String:AnyObject]]() //Array of dictionary

    override func viewDidLoad() {
        SVProgressHUD.show()
        super.viewDidLoad()
        Alamofire.request("https://newsapi.org/v1/articles?source=techcrunch&apiKey=1f4ebd7ef63a464c9ad2f68384c1aa05").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["articles"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    self.newsTable.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.newsTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!
        CustomCell
        var dict = arrRes[indexPath.row]
        cell.title.text = dict["title"] as? String
        cell.newsText.text = dict["description"] as? String
        SVProgressHUD.dismiss()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRes.count
    }
}
