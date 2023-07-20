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
        
        getComments(postId: 2)
    }
    
    private func getComments(postId: Int) {
        NetworkManager.shared.getComments(postId: String(postId)) { comments in
            switch comments {
            case .success(let success):
                success.forEach { comment in
                    print("\(comment.name): \(comment.email)")
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    }


}

