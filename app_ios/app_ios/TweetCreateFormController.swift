//
//  TweetCreateFormController.swift
//  app_ios
//
//  Created by kazuya.tsubone on 2017/11/24.
//  Copyright © 2017年 kazuya.tsubone. All rights reserved.
//

import UIKit
class TweetCreateFormController: UIViewController {

  @IBOutlet weak var titleText: UITextField!
  @IBOutlet weak var bodyText: UITextField!
    
  @IBAction func createButton(_ sender: UIButton) {
    print(titleText.text!)
    print(bodyText.text!)
    let tweet = Tweet(title: titleText.text!, body: bodyText.text!)
    tweet.createTweet(
      success: {
        print("success create")
      },
      failure: {(error) in
        print("fail create")
      }
    )
    navigationController?.popToRootViewController(animated: true)
  }
    
  override func viewDidLoad() {
    super.viewDidLoad()
  }
    
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
