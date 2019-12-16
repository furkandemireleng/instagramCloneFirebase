//
//  ViewController.swift
//  instaclonefirabese
//
//  Created by MacxbookPro on 15.11.2019.
//  Copyright © 2019 MacxbookPro. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //cuncel kullanici almak bunu soyle dusun bir kere giris yaptiginda bir daha atmayacak seni
        
    }

    @IBAction func signInButton(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (auth, error) in
                if error != nil {
                    self.makeAlert(titleInput: "error", messageInput: error?.localizedDescription ?? "error")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }else{
            makeAlert(titleInput: "Hata", messageInput: "email veya parola hatali")
        }
        
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        if emailText.text != "" && passwordText.text != ""{
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Hata")
                }
                else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }//bir obje olusturur
        } else{
            makeAlert(titleInput: "Error !", messageInput: "Email / Password ?")
            
        }
        
        
        }
    func makeAlert(titleInput:String , messageInput:String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let alertButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(alertButton)
        self.present(alert,animated: true , completion: nil)
        
        
        
    }
    
    
}

