//
//  FirstViewController.swift
//  Compare
//
//  Created by 加藤諒 on 2017/09/17.
//  Copyright © 2017年 mirai. All rights reserved.
//

import UIKit
import SwiftyJSON

class FirstViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
  @IBOutlet weak var rateBtn: UIButton!

  
  
  var testText:Int = 0
  
  // UserDefaults のインスタンス
  let userDefaults = UserDefaults.standard
  
  
  //日本円で50.0円のもの
  var amountJPY = 1.0
  
  
  var phpRate:Int = 0
  
  
  var section:[String] = ["チェーン店","カフェ"]
  

  let list:[String] = ["飲食店","コンビニ","雑貨","生活費","大きな買い物","電化製品","住宅","工事費","スーパー","Yoshinoya","服","文房具"]
  
  let imageDesu:[String] = ["CoffeeSrarbucks","Convenience7","Image-11","LivingOfCosts","Image-10","Image-2","Image-3","Image-12","Image-10","Image-10","Image-10","Image10"]
  

  //ここに保存されて、次の画面に送る！
  var selectedName = ""
  
  var selectedIndex = -1 //選択された行番号！
		

  @IBOutlet weak var myCollectionView: UICollectionView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    // デフォルト値 //userdefault
    userDefaults.register(defaults: ["DataStore": "default"])
    
    
    rateBtn.setTitle("現在のペソを確認\(Int(amountJPY))", for: .normal)
//    // URLを指定してオブジェクトを作成
//    let stringUrl = "http://api.aoikujira.com/kawase/json/jpy"
//    let url = URL(string: stringUrl)
//    let request = URLRequest(url: url!)
//    
//    // コンフィグを指定してHTTPセッションを生成
//    let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
    
//    // HTTP通信を実行する
//    // ※dataにJSONデータが入る
//    let task:URLSessionDataTask = session.dataTask(with: request, completionHandler: {data, responce, error in
//      // エラーがあったら出力
//      if error != nil {
//        print(error!)
//        return
//      }
//      
//      DispatchQueue.main.async {
//        // データ取得後の処理
//        
//        // JSONデータを食わせる
//        let json = JSON(data: data!)
//        
//        // ペソ
//        if let ratePHP = json["PHP"].string {
//          // StringからDouble型に変換
//          let rate = Double(ratePHP)!
//          // ペソに変換(小数第4位まで)
//          let amountPHP = round(self.amountJPY * rate * 10000) / 10000
//          // ラベルに表示
//          self.rateBtn.setTitle("\(amountPHP)ペソ", for: .normal) //= "\(amountUSD)ドル"
//          print(amountPHP)
//          
//          //amountPHP*cellの３番目のラベルを掛け算するやり方で実装を試みる
//          //cell.textJPYlabal.amounPHP*JPY
//          //問題はString型であること　はじめにInt型にするかを相談！
//          
//        } else {
//          // キー値不正などで値が取得できなかった場合の処理
//        }
//      }
//      
//      
//    })
//    
//    // HTTP通信を実行
//      task.resume()
    
    
  }
  

  
  
  @IBAction func rateBtn(_ sender: UIButton) {
    
    // URLを指定してオブジェクトを作成
    let stringUrl = "http://api.aoikujira.com/kawase/json/jpy"
    let url = URL(string: stringUrl)
    let request = URLRequest(url: url!)
    
    // コンフィグを指定してHTTPセッションを生成
    let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
    // HTTP通信を実行する
    // ※dataにJSONデータが入る
    let task:URLSessionDataTask = session.dataTask(with: request, completionHandler: {data, responce, error in
      // エラーがあったら出力
      if error != nil {
        print(error!)
        return
      }
      
      DispatchQueue.main.async {
        // データ取得後の処理
        
        // JSONデータを食わせる
        let json = JSON(data: data!)
        
        // ペソ
        if let ratePHP = json["PHP"].string {
          // StringからDouble型に変換
          let rate = Double(ratePHP)!
          // ペソに変換(小数第4位まで)
          let amountPHP = round(self.amountJPY * rate * 10000) / 10000
          // ラベルに表示
          self.rateBtn.setTitle("\(amountPHP)ペソ", for: .normal) //= "\(amountUSD)ドル"
          print(amountPHP)
          
          
          //ペソの計算！
          print(amountPHP * 40)
          
          
          var Rate:Int = 0
          
          if self.userDefaults.object(forKey: "DataStore") != nil{
            Rate = self.userDefaults.object(forKey: "DataStore") as! Int
          }
          self.userDefaults.set(Rate, forKey: "favArr")
          self.userDefaults.synchronize()
          
          
          //amountPHP*cellの３番目のラベルを掛け算するやり方で実装を試みる
          //cell.textJPYlabal.amounPHP*JPY
          //問題はString型であること　はじめにInt型にするかを相談！
          
        } else {
          // キー値不正などで値が取得できなかった場合の処理
          //アラート設定！
          
        }
      }
      
    })
    
    // HTTP通信を実行
    task.resume()
  }
  
  

  
  /*
   Cellが押された時
   */
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    selectedIndex = indexPath.row
    
//    if selectedIndex == 0 {
//      var selectedIndex20 = indexPath.row
//      var selectedName = placeListFood
//    }else if selectedIndex == 1 {
//      var selectedIndex = indexPath.row
//      var selectedName = placeListConvenience
//    }else if selectedIndex == 2{
//      var selectedIndex = indexPath.row
//      var selectedName:[String] = placeListShopAndGallery
//    }else if selectedIndex == 3 {
//      var selectedName:[String] = placeListLivingOfCosts
//    }else if selectedIndex == 4{
//      var selectedName:[String] = placeListBigShopping
//    }else if selectedIndex == 5{
//      var selectedName:[String] = placeListElectricAppliances
//    }else if selectedIndex == 6{
//      var selectedName:[String] = placeListDwelling
//    }else if selectedIndex == 7{
//      var selectedName:[String] = placeListConstruction
//    }
    //セグエを指定して、画面遷移 アイデンティファイヤーの通路！
    performSegue(withIdentifier: "next", sender: nil)
    
    print("Num: \(indexPath.row)")
    print("Value:\(collectionView)")
  }
  
  
  /*
   表示するセルの数！
   */
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return list.count
  }
  
  /*
   Cellに値を設定する
   */
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
   
    let cell:CustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
    
    cell.lblSample?.text = list[indexPath.row]
    cell.imgSample?.image = UIImage(named: imageDesu[indexPath.row])
    return cell
  }
  
  
  //セクションの値
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
    let Section = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Section", for: indexPath) as! CollectionReusableView
    Section.sectionLabel.text? = section[indexPath.section]
    
    return Section
  }
  
  
  // セクションの数（今回は1つ）
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
   return 2 //section.count
  }
  
  
  
  //override(上書き)だが、prepareはviewcontroller画面に組み込まれているため、上書きする必要がある！
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    
    //移動先の画面に渡したい情報をセットできる
    //dv　今から移動する画面のオブジェクト(インスタンス)
    //移動先画面のオブジェクトを取得！
    let dv: ViewController1_3 = segue.destination as! ViewController1_3
    
    //dv.scSelectedName = selectedName
    
    dv.scSelectedIndex = selectedIndex
    
    
    dv.ratePhp = phpRate
    
  }

  

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}



//一つだけでもオッケー！
//紹介したいエリア名が格納される配列

//  var placeListFood:[String] = []
//
//  var placeListConvenience:[String] = []
//
//  var placeListShopAndGallery:[String] = []
//
//  var placeListLivingOfCosts:[String] = []
//
//  var placeListBigShopping:[String] = []
//
//  var placeListElectricAppliances:[String] = []
//
//  var placeListDwelling:[String] = []
//
//  var placeListConstruction:[String] = []
//

