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
    var articleImage: UIImage = #imageLiteral(resourceName: "icon_photo")
    var articleTitle: String = ""
    var articleContent: String = ""
    var articleAutoId: String = ""
    
    @IBAction func goAddArticlePage(_ sender: UIButton) {
        articleImage = #imageLiteral(resourceName: "icon_photo")
        articleTitle = ""
        articleContent = ""
        articleAutoId = ""
        self.performSegue(withIdentifier: "GO_ADD", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addArticleViewController = segue.destination as? AddArticleViewController {
            addArticleViewController.articleManager = self.articleManager
            addArticleViewController.articleContent = self.articleContent
            addArticleViewController.articleTitle = self.articleTitle
            addArticleViewController.articleImage = self.articleImage
            addArticleViewController.articleAutoId = self.articleAutoId
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

        let imageAutoId = tableViewArticles[indexPath.row].autoId

        if let image: Data = UserDefaults.standard.value(forKey: "IMAGE_\(imageAutoId)") as? Data {
            cell.articleImageView.image = UIImage(data: image)
        } else {
            cell.articleImageView.image = #imageLiteral(resourceName: "icon_photo")
        }
        cell.articleTitleLabel.text = tableViewArticles[indexPath.row].title
        return cell
    }
    //selector
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let autoId = tableViewArticles[indexPath.row].autoId
        articleAutoId = autoId
        articleTitle = tableViewArticles[indexPath.row].title
        articleContent = tableViewArticles[indexPath.row].content
        if let imageData: Data = UserDefaults.standard.value(forKey: "IMAGE_\(autoId)") as? Data {
            guard let image = UIImage(data: imageData)
                
                else {
                articleImage =  #imageLiteral(resourceName: "icon_photo")
                return
                }
            
            articleImage = image
        } else {
            articleImage =  #imageLiteral(resourceName: "icon_photo")
        }
        self.performSegue(withIdentifier: "GO_ADD", sender: nil)
        
    }
    //delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let autoId = tableViewArticles[indexPath.row].autoId
            UserDefaults.standard.removeObject(forKey: autoId)
            UserDefaults.standard.removeObject(forKey: "IMAGE_\(autoId)")
            self.tableViewArticles.remove(at: indexPath.row)
            self.articleTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleManager.delegate = self
        articleManager.getArticle()
//        for key in UserDefaults.standard.dictionaryRepresentation().keys{
//            UserDefaults.standard.removeObject(forKey: key)
//        }
    }

}

