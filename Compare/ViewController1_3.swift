//
//  ViewController1_3.swift
//  Compare
//
//  Created by 加藤諒 on 2017/09/17.
//  Copyright © 2017年 mirai. All rights reserved.
//

import UIKit
//import FontAwesome_swift

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
  
  
  //let userDefaults = UserDefaults.standard

  
  //@IBAction func myBack1_3(_ sender: UIBarButtonItem) {}
  // Sectionで使用する配列を定義する.
  //private let mySections: NSArray = ["iPhone", "Android"]
  
  //var scSelectedIndex3 = -1
  
  @IBOutlet weak var myNavigation1_3: UINavigationBar!
  
  

  @IBOutlet weak var myTableView1_3: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
      // Keyを指定して読み込み
      UserDefaults.standard.integer(forKey: "DataStore")
      
      print(value(forKey: "DataStore"))

      
      print(scSelectedIndex)
  
      //tableViewを使えるようにする！
      self.myTableView1_3.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
      
      //プロパティリストの読み込み
      let filePathMc = Bundle.main.path(forResource: "McPrice", ofType: "plist")
      
      let filePathStb = Bundle.main.path(forResource: "StarbucksPrice", ofType: "plist")
      
      let filePath7 = Bundle.main.path(forResource: "7price", ofType: "plist")
      
      let filePathYoshinoya = Bundle.main.path(forResource: "YoshinoyaPrice", ofType: "plist")
      
      let filePathMarukame = Bundle.main.path(forResource: "Marukame", ofType: "plist")
      
      if 0 == scSelectedIndex{
        array = NSArray(contentsOfFile: (filePathMc)!)!
      }else if scSelectedIndex == 1{
        array = NSArray(contentsOfFile:filePathStb!)!
      }else if scSelectedIndex == 2{
        array = NSArray(contentsOfFile: filePath7!)!
      }else if scSelectedIndex == 3{
        array = NSArray(contentsOfFile: filePathYoshinoya!)!
      }else if scSelectedIndex == 4{
        array = NSArray(contentsOfFile: filePathMarukame!)!
      }
      
      
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
  
  
  
  //セクションの数
  func numberOfSections(in tableView: UITableView) -> Int {
    
    return array.count
    //return mySections.count
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
