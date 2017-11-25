//
//  TweetUpdateFormController.swift
//  app_ios
//
//  Created by kazuya.tsubone on 2017/11/25.
//  Copyright © 2017年 kazuya.tsubone. All rights reserved.
//

import UIKit

class TweetUpdateFormController: UIViewController {
    
  var tweet: Tweet?
    
  @IBOutlet weak var titleText: UITextField!
  @IBOutlet weak var bodyText: UITextField!
    
  override func viewDidLoad() {
    super.viewDidLoad()
    titleText.text = tweet?.title
    bodyText.text = tweet?.body
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
    
  @IBAction func updateButton(_ sender: Any) {
    //navigationController?.popViewController(animated: true)
    navigationController?.popToRootViewController(animated: true)
  }
}
