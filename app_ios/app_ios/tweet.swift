//
//  tweet.swift
//  app_ios
//
//  Created by kazuya.tsubone on 2017/11/24.
//  Copyright © 2017年 kazuya.tsubone. All rights reserved.
//

import UIKit

class Tweet: CustomStringConvertible {
  
  let title: String
  let body: String
  
  var description: String {
    return "title: \(self.title), body: \(self.body)"
  }
  
  init(title: String, body: String) {
    self.title = title
    self.body = body
  }
}
