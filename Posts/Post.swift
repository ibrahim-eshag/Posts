//
//  Post.swift
//  Posts
//
//  Created by Amged on 9/9/21.
//

import Foundation


class Post:Codable {
// pure Post Model
    
    // image
    // title
    // location
    // Author
    // description
    // shareNumer
    // MARK: time   === latter
    
    // properties
    var image: String
    var title: String
    var location: String
    var author: String
    var description: String
    var shareNumer: Int
    
    init( image: String, title: String,location: String,author: String, description: String,shareNumer: Int  ) {
        
        self.image = image
        self.title = title
        self.location = location
        self.author = author
        self.description = description
        self.shareNumer = shareNumer
    }
    
    
    // Methods
    
    
}
