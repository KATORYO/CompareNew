//
//  ThirdViewController3_1.swift
//  Compare
//
//  Created by 加藤諒 on 2017/10/08.
//  Copyright © 2017年 mirai. All rights reserved.
//

import UIKit

class ThirdViewController3_1: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
  
  @IBOutlet weak var myTableView: UITableView!
  

  var arrayDesu:[String] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
  
      UserDefaults.standard.integer(forKey: "fav")
      arrayDesu.append("fav")
      
      if UserDefaults.standard.object(forKey: "fav") != nil {print("Yes")}
      
      
    }
  
  
  //セクションの数
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  //セルの数
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrayDesu.count
  }
  
  
  //ここで画面を表示 cellに値を設定！
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell
    
    cell.textLabel?.text = "aa"
    
    return cell
  }
  
  //スワイプ処理！
  //なぜこれで表示されるのか？？＝＝delegateで委譲している為！
  // UITableViewDelegate
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let action = UITableViewRowAction(style: .default, title: "削除"){ action, indexPath in
      //ここでアクションを起こす！
    }
    
    return [action]
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
