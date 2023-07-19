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
        
//        NetworkManager.shared.getUser { users in
//            switch users {
//            case .success(let success):
//                success.forEach { user in
//                    print(user.name)
//                }
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        }
        
        NetworkManager.shared.getComments { comments in
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

