//
//  SearchResultVC.swift
//  Posts
//
//  Created by Amged on 8/29/21.
//

// Design Link:  https://miro.com/app/board/o9J_l3hd2CQ=/

// MVC
// M === Model ===> Data
// V = View == UIs
// C = Controller



import UIKit
//import Post

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postHeadline: UILabel!
    @IBOutlet weak var favouritedPost: UIImageView!
    @IBOutlet weak var locationIcon: UIImageView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postDescription: UILabel!

}


class SearchResultVC: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var postsTableView: UITableView!
    
    struct PostModel : Decodable {
        let _id : String
        let title : String
        let body : String
    }
   
    var myPosts = [PostModel]() // my empty post that will be filled from the backend

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.myPosts.count > 0 ? myPosts.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        if self.myPosts.count > 0 {
            print("postHeadline for the current post: \(self.myPosts[indexPath.row].title)")
            cell.postHeadline?.text = self.myPosts[indexPath.row].title
            cell.postDescription?.text = self.myPosts[indexPath.row].body
            

        }else{
            cell.postHeadline?.text = ""
        }
        
        cell.layoutMargins.bottom = 16
        
//        cell.postHeadline?.text = "xxx"
        return cell
    }
    // properties
  
    
//    let myPost = Post(image:"",title:"", location:"", author:"", description:"",shareNumer:50)

    
    
    @IBOutlet weak var SearchTextField: UITextField!
    
        // 1- the first and probably the easiest to start with, URLSession.....
        // 2- URLRequest
        // 3- URLComponents
        // 4- Almofire (which is external Library, but more elegant and widely used by iOS Developers).

    
//    we are going to use URLSESSION
    
    fileprivate func getDataFromendpoint() {
        
     // 1- the first and probably the easiest to start with, URLSession.....
        // 2- URLRequest
        // 3- URLComponents
        // 4- Almofire (which is external Library, but more elegant and widely used by iOS Developers).
          
        let url = URL(string: "http://localhost:5050/api/posts")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8)!)
            
            do {
            
                self.myPosts  = try JSONDecoder().decode([PostModel].self, from: data)
                
                if self.myPosts.count > 0{
                    
                    DispatchQueue.main.async {
                        self.postsTableView.reloadData()                    }
                }

            }catch let error{
                print("EEEErrror happened \(error)")
            }
        }
        
        task.resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromendpoint()
      

    }
    
    
//    implementing left image
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
//     calling endpoint to have posts
    
  

}
