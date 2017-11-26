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
    
    refreshControl = UIRefreshControl()
    refreshControl?.addTarget(self, action: #selector(onRefresh), for: UIControlEvents.valueChanged)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  override func viewWillAppear(_ animated: Bool) {
    refreshData()
  }
  
  func refreshData() {
    Tweet.getTweets(
      success: {(tweets) -> Void in
        self.tweets = tweets.reversed()
        self.tableView.reloadData()
    },
      failure: {(error) -> Void in
        // エラー処理
        let alertController = UIAlertController(title: "エラー", message: "エラーメッセージ", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    })
  }
  
  @objc func onRefresh(sender: UIRefreshControl) {
    print("refreshhhhhhhh")
    refreshControl?.beginRefreshing()
    Tweet.getTweets(
      success: {(tweets) -> Void in
        self.tweets = tweets.reversed()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    },
      failure: {(error) -> Void in
        // エラー処理
        let alertController = UIAlertController(title: "エラー", message: "エラーメッセージ", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        self.refreshControl?.endRefreshing()
    })
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
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      // Delete the row from the data source
      
      let tweet = self.tweets[indexPath.row]
      tweet.deleteTweet(
        success: {
          print("success delete")
          self.tweets.remove(at: indexPath.row)
          tableView.deleteRows(at: [indexPath], with: .fade)
        },
        failure: {(error) in
          print(error!)
          print("fail delete")
        }
      )
    }
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
