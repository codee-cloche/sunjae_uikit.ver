//
//  myPageViewController.swift
//  Diary
//
//  Created by grace kim  on 2022/07/26.
//

import UIKit

class myPageViewController: UIViewController {
    @IBOutlet weak var myPageBar: UINavigationBar!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    var editButton: UIBarButtonItem?
    
    var user: User?
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()

        // Do any additional setup after loading the view.
    }
    
    private func configureView(){
        guard let user = self.user else { return }
        self.userName.text = user.userName
        self.profilePic = user.profilePic
        self.editButton = UIBarButtonItem(image: UIImage(systemName: "pencil"), style: .plain, target: self, action: #selector(tapEditButton))
        self.navigationItem.rightBarButtonItem =
        self.editButton
    }
    
    @objc func tapEditButton(_sender: UIButton){
        guard let viewController =
                self.storyboard?
            .instantiateViewController(identifier:"changeProfileViewController") as? changeUserProfileViewController else {return}
        guard let indexPath = self.indexPath else {
            return
        }
        
        guard let user = self.user else {return}
       //TODO: 여기서부터 재개하기. 
    }
    

}
