//
//  ArticleManage.swift
//  Journals
//
//  Created by Evans Wu on 2018/6/7.
//  Copyright © 2018年 Evans Wu. All rights reserved.
//

import Foundation
import UIKit

class ArticleManager {
    
    weak var delegate: ArticleManagerDelegate?
    
    func getArticle() {
        var articles: [Article] = []
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            if let article = UserDefaults.standard.value(forKey: "\(key)") as? [String: Any] {
                if let title = article["title"] as? String {
                    if let content = article["content"] as? String {
                        if let autoid = article["autoid"] as? String {
                            let value = Article.init(title: title, content: content, autoId: autoid)
                            articles.append(value)
                        } else {  } //handle error
                    } else {  } //handle error
                } else {  } //handle error
            } else{  } //handle error
        }
        self.delegate?.manager(self, didFetch: articles)
    }
    
}
