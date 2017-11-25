//
//  TweetDetailViewController.swift
//  app_ios
//
//  Created by kazuya.tsubone on 2017/11/24.
//  Copyright © 2017年 kazuya.tsubone. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

  var tweet: Tweet?
  
  @IBOutlet weak var titleTextLabel: UILabel!
  @IBOutlet weak var bodyTextLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    if let tweet = self.tweet {
      titleTextLabel.text = tweet.title
      bodyTextLabel.text = tweet.body
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func editButton(_ sender: Any) {
    performSegue(withIdentifier: "showUpdate", sender: nil)
  }
    
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showUpdate" {
      let controller = segue.destination as! TweetUpdateFormController
      controller.tweet = tweet
    }
  }
}
