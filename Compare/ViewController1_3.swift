//
//  ViewController1_3.swift
//  Compare
//
//  Created by 加藤諒 on 2017/09/17.
//  Copyright © 2017年 mirai. All rights reserved.
//

import UIKit
import CoreData
import FontAwesome_swift

class ViewController1_3: UIViewController,UITableViewDelegate,UITableViewDataSource {

  @IBAction func myFavorite(_ sender: UIBarButtonItem) {
  }
  
  var dicB:NSDictionary = [:]
  
  var placeList:[String] = []
  
  var array:NSArray = []

  
  //firstViewからの値
  var scSelectedIndex = -1
  
  
  var amountPHP = 0
  
  var ratePhp:Int = 0
  
  let userDefault = UserDefaults.standard
  
  var arrayDesu:[String] = []

  
  //@IBAction func myBack1_3(_ sender: UIBarButtonItem) {}
  // Sectionで使用する配列を定義する.
  //private let mySections: NSArray = ["iPhone", "Android"]
 
  
  
  //coredateここから
  let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
  
  var contentFavorite:[String] = []
  
  var fetchedArray: [NSManagedObject] = []
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
    do {
      fetchedArray = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }


  
  
  @IBOutlet weak var myNavigation1_3: UINavigationBar!
  
  

  @IBOutlet weak var myTableView1_3: UITableView!
  
  // ボタンを用意
  private var addBtn: UIBarButtonItem!
  let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 30)] as [String: Any]
  

  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      //addBtnの作成　plainが文字だけのもの、titleは""
      addBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: "onClick")
      
      // 罫線を青色に設定.
      myTableView1_3.separatorColor = UIColor.blue

      
      //fontawsome適用！
      self.addBtn.setTitleTextAttributes(attributes, for: .normal)
      self.addBtn.title = String.fontAwesomeIcon(name: .star)
      
      
      //viewに表示！
      self.navigationItem.rightBarButtonItem = addBtn
      
      // Keyを指定して読み込み
//      UserDefaults.standard.integer(forKey: "DataStore")
//      
//      print(value(forKey: "DataStore"))
//
//      
//      print(scSelectedIndex)
  
      //tableViewを使えるようにする！
      self.myTableView1_3.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    
      
      
      
      //プロパティリストの読み込み
      let filePathMc = Bundle.main.path(forResource: "McPrice", ofType: "plist")
      
      let filePathStb = Bundle.main.path(forResource: "PriceStarbucks", ofType: "plist")
      
      let filePathConvenience = Bundle.main.path(forResource: "PriceConvenience", ofType: "plist")
      
      let filePathYoshinoya = Bundle.main.path(forResource: "PriceYoshinoya", ofType: "plist")
      
      let filePathMarukame = Bundle.main.path(forResource: "PriceMarukame", ofType: "plist")
      
      let filePathKfc = Bundle.main.path(forResource: "PriceKfc", ofType: "plist")
      
      
      //出来上がったら配列で記入してみる
//      let filePathaa:[String] = [Bundle.main.path(forResource: "McPrice", ofType: "plist")!]
      
      
      //簡単に書く
      switch scSelectedIndex{
      case 0:
        array = NSArray(contentsOfFile: (filePathMc)!)!
      case 1:
        array = NSArray(contentsOfFile:filePathStb!)!
      case 2:
        array = NSArray(contentsOfFile: filePathConvenience!)!
      case 3:
        array = NSArray(contentsOfFile: filePathYoshinoya!)!
      case 4:
        array = NSArray(contentsOfFile: filePathMarukame!)!
      case 5:
        array = NSArray(contentsOfFile: (filePathKfc)!)!
      case 6:
        array = NSArray(contentsOfFile:filePathStb!)!
      case 7:
        array = NSArray(contentsOfFile: filePathConvenience!)!
      case 8:
        array = NSArray(contentsOfFile: filePathYoshinoya!)!
      case 9:
        array = NSArray(contentsOfFile: filePathMarukame!)!
      case 10:
        array = NSArray(contentsOfFile: (filePathMc)!)!
      case 11:
        array = NSArray(contentsOfFile:filePathStb!)!
      case 12:
        array = NSArray(contentsOfFile: filePathConvenience!)!
      case 13:
        array = NSArray(contentsOfFile: filePathYoshinoya!)!
      case 14:
        array = NSArray(contentsOfFile: filePathMarukame!)!
      case 15:
        array = NSArray(contentsOfFile: (filePathMc)!)!
      case 16:
        array = NSArray(contentsOfFile:filePathStb!)!
      case 17:
        array = NSArray(contentsOfFile: filePathConvenience!)!
      case 18:
        array = NSArray(contentsOfFile: filePathYoshinoya!)!
      case 19:
        array = NSArray(contentsOfFile: filePathMarukame!)!
      default:
        break
      //ファイルパスの読み込み

      //array = NSArray(contentsOfFile: (filePathMc)!)!

      for data in array{
        let dic = data as! NSDictionary
        
        //Key配列の追加！
        placeList.append(dic["camera"] as! String)
        placeList.append(dic["item"] as! String)
        placeList.append(dic["pricePeso"] as! String)
        placeList.append(dic["priceYen"] as! String)
      }
    }
  }
  
  
  
  
  //CoreDataに保存されているデータの読み込み処理（READ）
  func read(){
    
    //AppDelegateを使う用意をしておく
    let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //エンティティを操作するためのオブジェクトを使用
    let viewContext = appD.persistentContainer.viewContext
    
    //どのエンティティからデータを取得してくるかc設定
    let query:NSFetchRequest<Favorite> = Favorite.fetchRequest()

    do{
      //保存されてるデータをすべて取得
      let fetchResults = try viewContext.fetch(query)
      
      //一件ずつ表示
      for result:AnyObject in fetchResults{
        let favorite:String? = result.value(forKey:"favorite") as? String
        
        if favorite == nil {
          print("0です")
        }else{
          contentFavorite.append(favorite!)
        }

      }
    }catch{
    }
    
    //画面表示
    //print(contentTitle[0]+memoNo)
    
    
   // myTitle.reloadInputViews()
  }

  
  
  
  
  // addBtnをタップしたときのアクション
  func onClick() {
    let alert = UIAlertController(title: "お気に入り追加", message: "お気に入り画面に追加されます", preferredStyle: .alert)
    //handlerはokボタンが押されたときに行いたい処理を指定する場所(オッケーが押されたときに発動する)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{
      (actiton: UIAlertAction)->Void in
      //ここでアラートがオッケーだった場合の処理を記述
      print("aa")
      
        let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //エンティティを操作するためのオブジェクトを作成
        let viewContext = appD.persistentContainer.viewContext
            
            //ToDoエンティティオブジェクトを作成
            let favorite = NSEntityDescription.entity(forEntityName: "Favorite", in: viewContext)
            
            //ToDoエンティティにレコード（行）を挿入するためのオブジェクトを作成
            let newRecord = NSManagedObject(entity: favorite!, insertInto: viewContext)
        
            //値のセット(アトリビュート毎に指定) forKeyはモデルで指定したアトリビュート名
         
            newRecord.setValue(String(), forKey: "favorite")
            
            newRecord.setValue(Date(), forKey: "saveDate")
            
            //レコード（行）の即時保存
            do{
              try viewContext.save()
            }catch {
              
        }
            self.read()
            
            print("viewWillDisappear")
          
    }))
    
    
    //アラートがキャンセルの場合
      alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel))
    
    //アラート表示
    present(alert,animated: true,completion: nil)
    
  }//addBtn(お気に入り)ボタンを押した時の閉じタグ
  
  
  //ヘッダー
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView:UIView = UIView()
    headerView.backgroundColor = UIColor.blue
    let headerLet = UILabel()
    
    return headerView
  }
  
  
  
  //セクションの数
  func numberOfSections(in tableView: UITableView) -> Int {
    
    return 1
   
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
  }
  
  
  //ここで画面を表示 cellに値を設定！
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
    
    //scSelectedIndex3 = indexPath.row
    
    //取り出す時は型の宣言しなければならない！ as!NS~~
    dicB = array[indexPath.row] as! NSDictionary
    
    
    
    cell.nameLabel.adjustsFontSizeToFitWidth = true
    cell.nameLabel.minimumScaleFactor = 0.5 //# 最小でも80%までしか縮小しない場合
    cell.PesoLabel.adjustsFontSizeToFitWidth = true
    cell.PesoLabel.minimumScaleFactor = 0.5 //# 最小でも80%までしか縮小しない場合
    
    
    
    cell.ProductsImage.image = UIImage(named: dicB["camera"] as! String)
    
    cell.nameLabel.text? = dicB["item"] as! String
    
    cell.PesoLabel.text? = dicB["pricePeso"] as! String
    
    cell.YenLabel.text? = dicB["priceYen"] as! String
    
    return cell
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
