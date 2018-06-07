//
//  Article.swift
//  Journals
//
//  Created by Evans Wu on 2018/6/7.
//  Copyright © 2018年 Evans Wu. All rights reserved.
//

import Foundation
class Article {
    let title: String
    let content: String
    let autoId: String
    init(title: String, content: String, autoId: String) {
        self.title = title
        self.content = content
        self.autoId = autoId
    }
}
