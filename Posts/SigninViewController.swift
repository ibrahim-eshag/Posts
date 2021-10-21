//
//  ViewController.swift
//  Posts
//
//  Created by Amged on 8/29/21.
//

import UIKit  // Library contain all ui elements

class SigninViewController: UIViewController {

    
    // properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField:
        
        UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
// Methods
    @IBAction func secureenteryFliper(_ sender: UIButton) {
        
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        
        
        if (sender.currentImage == UIImage(systemName: "eye")){

            let btnImage = UIImage(systemName: "eye.fill")
                        
            
            sender.setImage(btnImage , for: .normal)
            
            
            
        }else{
            sender.setImage(UIImage(systemName: "eye") , for: .normal)

            
        }
        
    }
    
    func callsignInendPoint()  {
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxNjkwMWZjZDFmMGM5ZjlmZGY3NTUzYyIsImlhdCI6MTYzNDI3MTc0MCwiZXhwIjoxNjM1MTM1NzQwfQ.V-pQ6JMDmp8Wy1nfXNNSlR0me1yFI8tg-XyEvx_DVME"
        
        let Url = String(format: "http://localhost:5050/api/users/login")
            guard let serviceUrl = URL(string: Url) else { return }
            let parameters: [String: Any] = [
                "email":emailTextField.text,
                "password":passwordTextField.text
            ]
           
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")

            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                return
            }
            request.httpBody = httpBody
            request.timeoutInterval = 20
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print("This is your login Response \(json)")
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
   
    
    @IBAction func signIn(_ sender: UIButton) {
        
        // we have to connect to backend and get the response back
        callsignInendPoint()
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let searchVC = storyBoard.instantiateViewController(withIdentifier: "searchViewController") as! SearchViewController
        
        searchVC.name = "Nithan"; //  the query to be sent to server
        
        
        // validation for creds
        if (emailTextField.text == "" || passwordTextField.text == "") {
            // we should check the response from backend
            print("You didn't enytered any Credentials...")
            
        }
        else{
        self.present(searchVC, animated: true, completion: nil)
        }
        
    }
    
    
}

