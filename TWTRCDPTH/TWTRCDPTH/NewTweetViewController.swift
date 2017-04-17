//
//  NewTweetViewController.swift
//  TWTRCDPTH
//
//  Created by Niraj Pendal on 4/16/17.
//  Copyright © 2017 Niraj. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {

    @IBOutlet weak var profileUserName: UILabel!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Tweet"
        
         self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
        let postButton = UIBarButtonItem(title: "Tweet", style: .plain, target: self, action: #selector(tweetButtonPressed))
        
        self.navigationItem.rightBarButtonItems = [postButton]

        let client = TwitterClient.sharedInstance
        
        client.currentUser(success: { (user:User) in
            print(user.name!)
            if let profileURL = user.profileURL {
                self.profileImageView.setImageWith(profileURL, placeholderImage: UIImage(named: "dummy"))
            }
            self.profileUserName.text = user.name
            self.profileNameLabel.text = user.screenName
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })

        
       
        
        // Do any additional setup after loading the view.
    }
    
    func  displayError(message:String)  {
        let alertView = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertView, animated: true, completion: nil)
    }
    
    func tweetButtonPressed()  {
        
        if tweetTextView.text == "" {
            displayError(message: "Tween Can't be empty")
        }
        
        print("Tweet Pressed")
        
        let client = TwitterClient.sharedInstance
        client.postTweet(text: tweetTextView.text) { [weak self] (response:Bool, error:Error?) in
            if error != nil {
                print("Error in Posting Tweet")
                self?.displayError(message: error!.localizedDescription)
            } else{
                print("Tweet posted.")
                self?.goBack()
            }
        }
    }
    
    func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func cancelButtonPressed() {
        print("cancel Presssed")
        goBack()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
