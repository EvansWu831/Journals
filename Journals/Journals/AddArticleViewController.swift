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
    @IBOutlet weak var addArticleImageView: UIImageView!
    @IBOutlet weak var addArticleTextField: UITextField!
    @IBOutlet weak var addArticleTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
    }
    @IBAction func didClose(_ sender: UIButton) {
        
    }
    
    @IBAction func addArticle(_ sender: UIButton) {
        //設置到本地資料庫
        guard let image: UIImage = addArticleImageView.image else { return }
        UserDefaults.standard.set(image, forKey: "ARTICLE_IMAGE")
        guard let title = addArticleTextField.text else { return }
        UserDefaults.standard.set(title, forKey: "ARTICLE_TITLE")
        guard let content = addArticleTextView.text else { return }
        UserDefaults.standard.set(content, forKey: "ARTICLE_CONTENT")
        //
    }
    
    func setImage() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(imageTapped(tapGestureRecognizer:)))
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
