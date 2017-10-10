//
//  SecondViewController.swift
//  Compare
//
//  Created by 加藤諒 on 2017/09/17.
//  Copyright © 2017年 mirai. All rights reserved.
//

import UIKit
import CoreData
import FontAwesome_swift

class SecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
  var myText:String!
  
  
  
  var contentTitle:[String] = []
  
  
  
  
  //appdelegateに書いた値を共有できるようにする
  var delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
  
  
  //メモNo
  var memoNo:Int = 0
  
  
  @IBOutlet weak var myTableViewMemo: UITableView!
 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    myTableViewMemo.delegate = self
    
    myTableViewMemo.reloadData()
    
    
    
//    read()
//    
//    reloadInputViews()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    read()
    
    reloadInputViews()
    myTableViewMemo.reloadData()
    
  }
  
  
  //CoreDataに保存されているデータの読み込み処理（READ）
  func read(){
    
    contentTitle = []
    
    //AppDelegateを使う用意をしておく
    let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //エンティティを操作するためのオブジェクトを使用
    let viewContext = appD.persistentContainer.viewContext
    
    //どのエンティティからデータを取得してくるか設定
    let query:NSFetchRequest<Memo> = Memo.fetchRequest()
    
    //データ一括取得
    do{
      //保存されてるデータをすべて取得
      let fetchResults = try viewContext.fetch(query)
      
      //一件ずつ表示
      for result:AnyObject in fetchResults{
        let memo:String? = result.value(forKey:"memo") as? String
        
        
        print("memo:\(memo!)")
        contentTitle.append(memo as! String)
        
        
        
        //  print(contentTitle[])
        
        
      }
    }catch{
    }
  }
  
  
  
 

override func didReceiveMemoryWarning() {
  super.didReceiveMemoryWarning()
  // Dispose of any resources that can be recreated.
}

  
  //セクションの数
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  //表示するセルの数
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    //必要な処理か？
    if contentTitle.count == 0{
    return 0
    }else{
      return contentTitle.count
    }
    
  }
  
  
  //cellに表示させる　値を決める
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell
    
//    let sectionData = contentTitle[indexPath.row]
//    let cellData = sectionData
    if contentTitle == nil {
      cell.textLabel?.text = ""
    }else{
        cell.textLabel?.text = contentTitle[indexPath.row]
    }
    
      //cell.textLabel?.text = contentTitle[memoNo]
    
    //入力したときのデータを入れたい！
      //cell.detailTextLabel?.text = data_in_code_entry
      cell.accessoryType = .disclosureIndicator
    
//    
    
    //contentTitle[1] = memoNo
    //cell.textLabel!.text = contentTitle[]
    //cell.textLabel!.text = contentTitle[indexPath.row]
    
    return cell
  }

    //押された時の処理//データ受け渡し画面
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
     self.memoNo = indexPath.row
    //selectedIndex = indexPath.row
    
    performSegue(withIdentifier: "next3", sender: nil)
  }
  
  
  
  //ユーザー記録の上にある書き込みマーク
  @IBAction func newPage(_ sender: UIBarButtonItem) {
 
      performSegue(withIdentifier: "next3", sender: nil)
    }
  
  
  //エディットボタン！
  @IBAction func editBtn(_ sender: UIBarButtonItem) {
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
  
  

  
  //受け渡しメソッド
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if (segue.identifier == "next3") {
      let subVC: SecondViewController2_2 = (segue.destination as? SecondViewController2_2)!
      subVC.MemoNo = self.memoNo
      print(memoNo)
    }
  }
  
  

  
  
  @IBAction func back (_ segue:UIStoryboardSegue){}
  
  
  
}//class閉じ
