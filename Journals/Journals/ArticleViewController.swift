//
//  ViewController.swift
//  Journals
//
//  Created by Evans Wu on 2018/6/7.
//  Copyright © 2018年 Evans Wu. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var articleTableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = articleTableView.dequeueReusableCell(withIdentifier: "ARTICLE_CELL", for: indexPath) as! ArticleTableViewCell
        if let image: Data = UserDefaults.standard.value(forKey: "EVANSARTICLE_IMAGE") as? Data {
            cell.articleImageView.image = UIImage(data: image)
        } else {
            cell.articleImageView.image = #imageLiteral(resourceName: "icon_photo")
        }
        
        cell.articleTitleLabel.text = "test"
        return cell
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            print("資料", key)
        }
        print("總共有", UserDefaults.standard.dictionaryRepresentation().count, "筆資料")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

