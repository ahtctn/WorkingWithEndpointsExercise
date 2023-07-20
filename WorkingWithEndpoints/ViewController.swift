//
//  ViewController.swift
//  WorkingWithEndpoints
//
//  Created by Ahmet Ali ÇETİN on 19.07.2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getComments(postId: 2)
        posts(title: "Merhaba arkadaşlar", body: "Benim adım ahmet ali çetin", userId: 43)
    }
    
    private func getComments(postId: Int) {
        NetworkManager.shared.getComments(postId: String(postId)) { comments in
            switch comments {
            case .success(let success):
                success.forEach { comment in
                    print(comment.body)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    private func posts(title: String, body: String, userId: Int) {
        NetworkManager.shared.posts(title: title, body: body, userId: userId) { posts in
            switch posts {
            case .success(let post):
                print(post.title as Any)
                print(post.body as Any)
                print(post.userId as Any)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

