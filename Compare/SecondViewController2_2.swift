//
//  SecondViewController2_2.swift
//  Compare
//
//  Created by 加藤諒 on 2017/10/01.
//  Copyright © 2017年 mirai. All rights reserved.
//

import UIKit
import CoreData
import FontAwesome_swift

class SecondViewController2_2: UIViewController,UITextViewDelegate {
  
  
  
  let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Memo")
  
  //メモNo
  var MemoNo = -1
  
  //メモ内容
  @IBOutlet weak var myTitle: UITextView!
  
  //インスタンスの作成
  //let saves = UserDefaults.standard
  
  //@NSManaged var name: String
  
  var contentTitle:[String] = []
  
  var fetchedArray: [NSManagedObject] = []
  
  
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    print(MemoNo)
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Memo")
    do {
      fetchedArray = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }
  
  
  
  //保存   //（機能していない）
  @IBAction func saveButton(sender: AnyObject) {
    //AppDelegateを使う用意をしておく
    let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    //エンティティを操作するためのオブジェクトを作成
    let viewContext = appD.persistentContainer.viewContext
    //ToDoエンティティオブジェクトを作成
    let Memo = NSEntityDescription.entity(forEntityName: "Memo", in: viewContext)
    //ToDoエンティティにレコード（行）を挿入するためのオブジェクトを作成
    let newRecord = NSManagedObject(entity: Memo!, insertInto: viewContext)
    //値のセット(アトリビュート毎に指定) forKeyはモデルで指定したアトリビュート名
    newRecord.setValue(myTitle.text, forKey: "memo")
    //レコード（行）の即時保存
    do{
      try viewContext.save()
    }catch{
    }
    //配列再取得
    //配列を空っぽにして、readで再び読み込み。
    //reloadDataでリアルタイム表示を可能にさせる
    //contentTitle = []
    fetchedArray = []
    read()
    myTitle.reloadInputViews()
    //myTitle.reloadData()
  }//保存ボタンの閉じたぐ
  
  
  
  //一つ前に戻る処理+保存処理！（機能していない）
  @IBAction func backBtn(_ sender: UIBarButtonItem) {
    let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let viewContext = appD.persistentContainer.viewContext
    let Memo = NSEntityDescription.entity(forEntityName: "Memo", in: viewContext)
    let newRecord = NSManagedObject(entity: Memo!, insertInto: viewContext)
    newRecord.setValue(myTitle.text, forKey: "memo")
    do{
      try viewContext.save()
    }catch{
    }
    fetchedArray = []
    read()
    myTitle.reloadInputViews()
    //performSegue(withIdentifier: "next4", sender: nil)
  }

  
  
  
  
  //テキストを閉じる処理
  @IBAction func closeBtn(_ sender: UIBarButtonItem) {
      myTitle.resignFirstResponder()
  }
  
  
  
  //戻るボタン　フォントオーサムで弄る為の
  @IBOutlet weak var BackBtn: UIBarButtonItem!
  
  
  
  //viedDidLoad
  override func viewDidLoad() {
        super.viewDidLoad()
    
  
    // キーボードの上部にビューをセットする
    //myTitle.inputAccessoryView = UILabel()
    
    
    let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20)] as [String: Any]
    BackBtn.setTitleTextAttributes(attributes, for: .normal)
    BackBtn.title = String.fontAwesomeIcon(name: .stepBackward)
    
    //CoreDataからデータを読み込む処理
    read()
    
    myTitle.text? = ""
    
      //ここが一つ前の新規ボタンを押しても表示されない鍵
    if MemoNo == -1 {
      myTitle.text? = ""
    }else{
      myTitle.text? = contentTitle[MemoNo]

    }
      //myTitle.text? = contentTitle[]
    
    
    
    
    //ペーストなどの処理をはる！
    // MenuController生成.
    let myMenuController: UIMenuController = UIMenuController.shared
    
    // MenuControllerを表示.
    myMenuController.isMenuVisible = true
    
    // 矢印の向きを下に設定.
    myMenuController.arrowDirection = UIMenuControllerArrowDirection.down
    
    // rect、viewを設定.
    myMenuController.setTargetRect(CGRect.zero, in: self.view)
    
    // MenuItem生成.
    let myMenuItem_1: UIMenuItem = UIMenuItem(title: "Menu1", action: #selector(SecondViewController2_2.onMenu1(sender:)))
    let myMenuItem_2: UIMenuItem = UIMenuItem(title: "Menu2", action: #selector(SecondViewController2_2.onMenu2(sender:)))
    let myMenuItem_3: UIMenuItem = UIMenuItem(title: "Menu3", action: #selector(SecondViewController2_2.onMenu3(sender:)))
    
    // MenuItemを配列に格納.
    let myMenuItems: NSArray = [myMenuItem_1, myMenuItem_2, myMenuItem_3]
    
    // MenuControllerにMenuItemを追加.
    myMenuController.menuItems = myMenuItems as? [UIMenuItem]
  }
  
  
  //textviewに編集する
   //UITextFieldが編集開始された直後に呼ばれる.
  func textViewDidBeginEditing(_ textField: UITextField) {
    print("textFieldDidBeginEditing:" + textField.text!)
  }
  
  //テキストビューに編集する
   //UITextFieldが編集終了する直前に呼ばれる.
  func textViewShouldEndEditing(_ textField: UITextField) -> Bool {
    print("textFieldShouldEndEditing:" + textField.text!)
    return true
  }
  
  
   //作成したMenuItemが表示されるようにする.
  override func canPerformAction(_ action: Selector, withSender sender: Any!) -> Bool {
    if action == #selector(SecondViewController2_2.onMenu1(sender:)) || action == #selector(SecondViewController2_2.onMenu2(sender:)) || action == #selector(SecondViewController2_2.onMenu3(sender:))  {
      return true
    }
    return false
  }
  
  
  //MenuItemが押されたとき！！
  internal func onMenu1(sender: UIMenuItem) {
    print("onMenu1")
  }
  
  internal func onMenu2(sender: UIMenuItem) {
    print("onMenu2")
  }
  
  internal func onMenu3(sender: UIMenuItem) {
    print("onMenu3")
  }
  
  
  
  

  //CoreDataに保存されているデータの読み込み処理（READ）
  func read(){
    
    //AppDelegateを使う用意をしておく
    let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //エンティティを操作するためのオブジェクトを使用
    let viewContext = appD.persistentContainer.viewContext
    
    //どのエンティティからデータを取得してくるかc設定
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
        
        //print("memo:\(contentTitle[1])")
        

        
      }
    }catch{
    }
    
    //画面表示
    //print(contentTitle[0]+memoNo)
    //応急処置
    //var iiii = contentTitle[0]
    
    //print(contentTitle[MemoNo])
    
//    if contentTitle == nil{
//      var contentTitle:[String] = ["MemoNo"]
//    }else{
//      var contentTitle:0 = [""]
//    }
//  
//    if contentTitle == nil{
//      myTitle.text = ""
//    }else{
//      myTitle.text? = contentTitle[]
//    }
//    
    //myTitle.text = contentTitle[MemoNo]
    
   
    myTitle.reloadInputViews()
  }
  
  
  //削除ボタンが押された時(DELETEに当たる処理)
  @IBAction func tapDeleate(_ sender: UIBarButtonItem) {
    
    //AppDelegateを使う用意をしておく
    let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //エンティティを操作するためのオブジェクトを使用
    let viewContext = appD.persistentContainer.viewContext
    
    //どのエンティティからデータを取得してくるか設定
    let query:NSFetchRequest<Memo> = Memo.fetchRequest()
    
    
    //データを一括取得
    do{
      let fetchRequests = try viewContext.fetch(query)
      
      for result:AnyObject in fetchRequests{
        //取得したデータを指定し、削除
        let record = result as! NSManagedObject
        viewContext.delete(record)
      }
      //削除した状態を保存
      try viewContext.save()
      
    }catch{
      
  }
    contentTitle = []
    read()
    myTitle.reloadInputViews()
}

  
  
  
  //新規作成ボタン（compose）
  @IBAction func newPageBtn(_ sender: UIBarButtonItem) {
    
    performSegue(withIdentifier: "nextAgain", sender: nil)
    
  }

  
  
  
  //画面から非表示になる直前に呼ばれる！
  //画面が戻るときに！
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    
    var nakamiComfirm = ""
    
    nakamiComfirm = myTitle.text
    
    if myTitle.text == myTitle.text{
      print("これは同じなのでセーブしません")
    }else{
      print("セーブします")
    }
    
    if nakamiComfirm == ""{
      print("保存しない")
    }else{
    let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //エンティティを操作するためのオブジェクトを作成
    let viewContext = appD.persistentContainer.viewContext
    
    //ToDoエンティティオブジェクトを作成
    let Memo = NSEntityDescription.entity(forEntityName: "Memo", in: viewContext)
    
    //ToDoエンティティにレコード（行）を挿入するためのオブジェクトを作成
    let newRecord = NSManagedObject(entity: Memo!, insertInto: viewContext)
    
    //値のセット(アトリビュート毎に指定) forKeyはモデルで指定したアトリビュート名
    
    
    newRecord.setValue(myTitle.text, forKey: "memo")
    
    //レコード（行）の即時保存
      do{
        try viewContext.save()
      }catch {
        
      }
    
    read()
    
    myTitle.reloadInputViews()
    
    print("viewWillDisappear")
    }
}


  override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
  }
    // cell.textLabel!.text = self.saves

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
