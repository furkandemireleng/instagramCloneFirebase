//
//  UploadViewController.swift
//  instaclonefirabese
//
//  Created by MacxbookPro on 15.11.2019.
//  Copyright © 2019 MacxbookPro. All rights reserved.
//

import UIKit
import Firebase



class UploadViewController: UIViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var commentText: UITextField!
    
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController,animated: true,completion: nil)
        
        
    }
    //sectikten sonra ne olacak
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func makeAlert(titleInput:String,messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert,animated: true,completion: nil)
        
    }
    

    @IBAction func uploadButton(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        //refgeranslari kullanarak hangi klasorle calisilicaz nerey kaydedice vs velirtiyoruz
        
        let mediaFolder = storageReference.child("media")
        
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            
            let uuid = UUID().uuidString
            
            //ne kadar sikistirayim dedi 0.5 yani yarisi kadar sikistir dedik
            let imageReferance = mediaFolder.child("\(uuid).jpg") //uuid stringini jpg olarak kaydettik
            
            imageReferance.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "ERROR")
                }else{
                    imageReferance.downloadURL { (url, error) in
                        if error == nil {
                            //kaydedilen datayi gormek icin bunu yaptik
                            let imageUrl = url?.absoluteString
                            
                            
                            //database
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            var firestoreReferance :DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl" : imageUrl! , "postedBy" :Auth.auth().currentUser!.email, "postComment":self.commentText.text!, "date":FieldValue.serverTimestamp(),"likes" : 0] as [String : Any]
                            
                            firestoreReferance = firestoreDatabase.collection("Posts").addDocument(data:firestorePost, completion: { (error) in
                                if error != nil {
                                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
                                }else{
                                    //hatasiz bir sekilde yuklendiysek bizi feed'e goturecek 2 deseydik settings 1 de upload
                                    //self.imageView.image = UIImage(named: "Image.png")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                        }
                    }
                }
            }
            
        }
        
    }
    

}
