//
//  TweetsViewController.swift
//  app_ios
//
//  Created by kazuya.tsubone on 2017/11/24.
//  Copyright © 2017年 kazuya.tsubone. All rights reserved.
//

import UIKit

class TweetsViewController: UITableViewController {

  private var tweets:[Tweet] = [Tweet(title: "hoge", body: "hogehoge"),
                                Tweet(title: "foo", body: "fooooo"),
                                Tweet(title: "bar", body: "barbar")]

  override func viewDidLoad() {
    super.viewDidLoad()
    // Navigation Barに新規投稿ボタンを追加
    let newTweetButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTouchNewTweetBarButton(_:)))
    navigationItem.rightBarButtonItem = newTweetButton
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // 新規投稿ボタンが押された時にフォームを表示
  @objc func didTouchNewTweetBarButton(_ sender: UIBarButtonItem) {
    performSegue(withIdentifier: "showCreate", sender: nil)
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return tweets.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
   
    let tweet = tweets[indexPath.row]
    cell.textLabel?.text = tweet.title
   
    return cell
  }
  
  override func tableView(_ table: UITableView, didSelectRowAt indexPath: IndexPath) {
      performSegue(withIdentifier: "showDetail", sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        let tweet = tweets[indexPath.row]
        let controller = segue.destination as! TweetDetailViewController
        controller.tweet = tweet
      }
    }
  }
}
