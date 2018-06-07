//
//  ViewController.swift
//  Journals
//
//  Created by Evans Wu on 2018/6/7.
//  Copyright © 2018年 Evans Wu. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ArticleManagerDelegate {

    @IBOutlet weak var articleTableView: UITableView!
    let articleManager = ArticleManager()
    var tableViewArticles:[Article] = []
    
    @IBAction func goAddArticlePage(_ sender: UIButton) {
        self.performSegue(withIdentifier: "GO_ADD", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addArticleViewController = segue.destination as? AddArticleViewController {
            addArticleViewController.articleManager = self.articleManager
        } else { } //handle error
    }
    
    func manager(_ manager: ArticleManager, didFetch articles: [Article]) {
        tableViewArticles = articles
        self.articleTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = articleTableView.dequeueReusableCell(withIdentifier: "ARTICLE_CELL", for: indexPath) as! ArticleTableViewCell
//        if let image: Data = UserDefaults.standard.value(forKey: "EVANSARTICLE_IMAGE") as? Data {
//            cell.articleImageView.image = UIImage(data: image)
//        } else {
//
//        }
        let imageAutoId = tableViewArticles[indexPath.row].autoId
        if let image: Data = UserDefaults.standard.value(forKey: "IMAGE_\(imageAutoId)") as? Data {
            cell.articleImageView.image =  UIImage(data: image)
        } else {
            cell.articleImageView.image =  #imageLiteral(resourceName: "icon_photo")
        }
        cell.articleTitleLabel.text = tableViewArticles[indexPath.row].title
        return cell
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleManager.delegate = self
        articleManager.getArticle()
        
        //刪除所有資料
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
        print("\(key)")
//        UserDefaults.standard.removeObject(forKey: "\(key)")
        }
        print("總共有", UserDefaults.standard.dictionaryRepresentation().count, "筆資料")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

