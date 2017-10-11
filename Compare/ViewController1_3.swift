//
//  ViewController1_3.swift
//  Compare
//
//  Created by 加藤諒 on 2017/09/17.
//  Copyright © 2017年 mirai. All rights reserved.
//

import UIKit
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
  
  let userDefaults = UserDefaults.standard
  
  var arrayDesu:[String] = []

  
  //@IBAction func myBack1_3(_ sender: UIBarButtonItem) {}
  // Sectionで使用する配列を定義する.
  //private let mySections: NSArray = ["iPhone", "Android"]
  
  //var scSelectedIndex3 = -1
  
  @IBOutlet weak var myNavigation1_3: UINavigationBar!
  
  

  @IBOutlet weak var myTableView1_3: UITableView!
  
  // ボタンを用意
  private var addBtn: UIBarButtonItem!
  let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 30)] as [String: Any]
  

  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      //addBtnの作成　plainが文字だけのもの、titleは""
      addBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: "onClick")
      
      
      
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
      
//      for n in 20{
//        let filePath = Bundle.main.path(forResource: "something", ofType: "plist")
//      }
      
      
      //プロパティリストの読み込み
      let filePathMc = Bundle.main.path(forResource: "McPrice", ofType: "plist")
      
      let filePathStb = Bundle.main.path(forResource: "StarbucksPrice", ofType: "plist")
      
      let filePath7 = Bundle.main.path(forResource: "7price", ofType: "plist")
      
      let filePathYoshinoya = Bundle.main.path(forResource: "YoshinoyaPrice", ofType: "plist")
      
      let filePathMarukame = Bundle.main.path(forResource: "Marukame", ofType: "plist")
      
      
      //簡単に書く
      switch scSelectedIndex{
      case 0:
        array = NSArray(contentsOfFile: (filePathMc)!)!
      case 1:
        array = NSArray(contentsOfFile:filePathStb!)!
      case 2:
        array = NSArray(contentsOfFile: filePath7!)!
      case 3:
        array = NSArray(contentsOfFile: filePathYoshinoya!)!
      case 4:
        array = NSArray(contentsOfFile: filePathMarukame!)!
      case 5:
        array = NSArray(contentsOfFile: (filePathMc)!)!
      case 6:
        array = NSArray(contentsOfFile:filePathStb!)!
      case 7:
        array = NSArray(contentsOfFile: filePath7!)!
      case 8:
        array = NSArray(contentsOfFile: filePathYoshinoya!)!
      case 9:
        array = NSArray(contentsOfFile: filePathMarukame!)!
      case 10:
        array = NSArray(contentsOfFile: (filePathMc)!)!
      case 11:
        array = NSArray(contentsOfFile:filePathStb!)!
      case 12:
        array = NSArray(contentsOfFile: filePath7!)!
      case 13:
        array = NSArray(contentsOfFile: filePathYoshinoya!)!
      case 14:
        array = NSArray(contentsOfFile: filePathMarukame!)!
      case 15:
        array = NSArray(contentsOfFile: (filePathMc)!)!
      case 16:
        array = NSArray(contentsOfFile:filePathStb!)!
      case 17:
        array = NSArray(contentsOfFile: filePath7!)!
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
  
  
  
  // addBtnをタップしたときのアクション
  func onClick() {
    let alert = UIAlertController(title: "お気に入り追加", message: "お気に入り画面に追加されます", preferredStyle: .alert)
    //handlerはokボタンが押されたときに行いたい処理を指定する場所(オッケーが押されたときに発動する)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{
      (actiton: UIAlertAction)->Void in
      //ここでアラートがオッケーだった場合の処理を記述
      print("aa")
      
      UserDefaults.standard.set(self.scSelectedIndex, forKey: "fav")
      
      //userDefault存在の確認！
      if UserDefaults.standard.object(forKey: "fav") != nil {print("aaaaaaa")}
      self.arrayDesu.append("fav")
      
      //配列の確認
      print(self.arrayDesu.count)
      
      
    }))
    
    
    //アラートがキャンセルの場合
      alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel))
    
    //アラート表示
    present(alert,animated: true,completion: nil)
    
  }//addBtn(お気に入り)ボタンを押した時の閉じタグ
  
  
  
  
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
