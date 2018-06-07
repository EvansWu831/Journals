//
//  ArticleManageDelegate.swift
//  Journals
//
//  Created by Evans Wu on 2018/6/7.
//  Copyright © 2018年 Evans Wu. All rights reserved.
//

import Foundation

protocol ArticleManagerDelegate: class {
    func manager(_ manager: ArticleManager, didFetch articles: [Article])
}
