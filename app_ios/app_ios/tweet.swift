//
//  tweet.swift
//  app_ios
//
//  Created by kazuya.tsubone on 2017/11/24.
//  Copyright © 2017年 kazuya.tsubone. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import SwiftyJSON

class Tweet: Mappable, CustomStringConvertible {
  
  var id: Int?
  var title: String?
  var body: String?
  
  var description: String {
    return "title: \(String(describing: self.title)), body: \(String(describing: self.body))"
  }
  
  init(title: String, body: String) {
    self.title = title
    self.body = body
  }

  required init?(map: Map) {
  }
  
  func mapping(map: Map) {
    id    <- map["id"]
    title <- map["title"]
    body  <- map["body"]
  }
  
  class func getTweets(success: @escaping (_ : [Tweet]) -> Void, failure: @escaping (_ error: Error?)-> Void) {

    Alamofire.request("http://192.168.33.10:3000/tweets.json").responseJSON { response in
      
      if let error = response.result.error {
        failure(error)
        return
      }
      let json = JSON(response.result.value!)
      let tweets: [Tweet] = json.arrayValue.map{tweetJson -> Tweet in
        return Mapper<Tweet>().map(JSONString: String(describing: tweetJson))!
      }
      success(tweets)
      
    }
  }
  
  func createTweet(success: @escaping () -> Void, failure: @escaping (_ error: Error?) -> Void) {
    
    let params: [String: AnyObject] = [
      "title" : self.title! as AnyObject,
      "body"  : self.body! as AnyObject
    ]
    
    Alamofire.request("http://192.168.33.10:3000/tweets.json", method: .post, parameters: ["tweet": params]).responseJSON { response in
      if let error = response.result.error {
        failure(error)
        return
      }
      success()
      return
    }
  }
  
  func updateTweet(success: @escaping () -> Void, failure: @escaping (_ error: Error?) -> Void) {
    
    let params: [String: AnyObject] = [
      "title" : self.title! as AnyObject,
      "body"  : self.body! as AnyObject
    ]
    
    Alamofire.request("http://192.168.33.10:3000/tweets/\(self.id!).json", method: .patch, parameters: ["tweet": params]).responseJSON { response in
      if let error = response.result.error {
        failure(error)
        return
      }
      success()
      return
    }
  }
  
  func deleteTweet(success: @escaping () -> Void, failure: @escaping (_ error: Error?) -> Void) {
    
    Alamofire.request("http://192.168.33.10:3000/tweets/\(self.id!).json", method: .delete).responseJSON { response in
      if let error = response.result.error {
        failure(error)
        return
      }
      success()
      return
    }
  }
  
  
}
