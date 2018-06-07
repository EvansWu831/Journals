//
//  AddArticleViewController.swift
//  Journals
//
//  Created by Evans Wu on 2018/6/7.
//  Copyright © 2018年 Evans Wu. All rights reserved.
//

import Foundation
import UIKit

class AddArticleViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var addArticleImageView: UIImageView!
    @IBOutlet weak var addArticleTextField: UITextField!
    @IBOutlet weak var addArticleTextView: UITextView!
    var articleManager = ArticleManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        saveButton.layer.masksToBounds = true
        saveButton.layer.cornerRadius = 22.5
    }
    
    //點擊Close按鈕
    @IBAction func didClose(_ sender: UIButton) {
        self.dismiss(animated: true, completion:nil)
    }
    
    //點擊SAVE按鈕
    @IBAction func addArticle(_ sender: UIButton) {
        //設置到本地資料庫
        guard let image: UIImage = addArticleImageView.image else { return }
        guard let title = addArticleTextField.text else { return }
        guard let content = addArticleTextView.text else { return }
        let userDefaults = UserDefaults.standard
        let autoid = randomString(length: 10)
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        userDefaults.set(["title": title, "content": content, "autoid": autoid], forKey: "\(autoid)")
        userDefaults.set(imageData, forKey: "IMAGE_\(autoid)")
        articleManager.getArticle()
        self.dismiss(animated: true, completion:nil)
    }
    
    //設置點擊相片功能
    func setImage() {
        addArticleImageView.image = #imageLiteral(resourceName: "icon_photo")
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        addArticleImageView.isUserInteractionEnabled = true
        addArticleImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let picker: UIImagePickerController = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String: Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            addArticleImageView.image = image
        } else { return } //handle error
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //隨機字串
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }

}
