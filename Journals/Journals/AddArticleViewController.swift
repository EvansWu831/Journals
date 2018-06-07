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
        let userDefaults = UserDefaults.standard
        guard let image: UIImage = addArticleImageView.image else { return }
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        guard let title = addArticleTextField.text else { return }
        guard let content = addArticleTextView.text else { return }
        userDefaults.set(imageData, forKey: "\(title)ARTICLE_IMAGE")
        userDefaults.set(title, forKey: "\(title)ARTICLE_TITLE")
        userDefaults.set(content, forKey: "\(title)ARTICLE_CONTENT")
        
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

}
