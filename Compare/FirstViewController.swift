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
  
  //植物・ガーデニング
  
  let list:[String] = ["飲食店全般","STARBUCKS","CoffeeBean","ケンタッキーKFC","丸亀正麺","マクドナルド","吉野家","コンビニ","調理器具","ゲーム＆カセット１０","おもちゃ","スーパー（食品）","スーパー（飲料・お酒）","寝具","車・バイク系","家電・カメラ・AV機器","DVD・ミュージック","インターネット関連","住宅関連","ファッション","スポーツ用品","本・コミック・雑誌20","本屋で買える文房具","生活費","工事費","修理費","その他"]
  
  var aaaa:[String] = ["aaaa","aaaa"]
  
  let imageDesu:[String] = ["CoffeeSrarbucks","Image-2","Image-1","LivingOfCosts","Image","McDonalds.Top","YoshinoyaGyudon","first","Image-10","Image-10","Image-10","Image10","CoffeeSrarbucks","Convenience7","Image-11","LivingOfCosts","Image-10","Image-2","Image-3","Image-12","Image-10","","","",]
  

  //ここに保存されて、次の画面に送る！
  var selectedName = ""
  
  var selectedIndex = -1 //選択された行番号！
		
  
  
  @IBOutlet weak var myCollectionView: UICollectionView!

  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // TouchDownの時のイベントを追加する.
    rateBtn.addTarget(self, action: #selector(FirstViewController.onDownButton(sender:)), for: .touchDown)
    
    // TouchUpの時のイベントを追加する.
    rateBtn.addTarget(self, action: #selector(FirstViewController.onUpButton(sender:)), for: [.touchUpInside,.touchUpOutside])
    
    
    print("リストの数\(list.count)")
    print("イメージの数\(imageDesu.count)")
    
    // デフォルト値 //userdefault
    userDefaults.register(defaults: ["DataStore": "default"])
    
    
    rateBtn.setTitle("現在のペソを確認\(Int(amountJPY))", for: .normal)

    
    //rateBtnの起動時アニメーション
    UIView.animate(withDuration: 1.5,
                   animations: {
                    self.rateBtn.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }, //戻るまでの秒数
        completion: { _ in
        UIView.animate(withDuration: 1.0) {
        self.rateBtn.transform = CGAffineTransform.identity
        }
    })
    
    
    /*
     移動するアニメーション.
     */

    rateBtn.layer.position = CGPoint(x: -30, y: 0)
    
    // アニメーション処理
    UIView.animate(withDuration: TimeInterval(CGFloat(2.0)),
    animations: {() -> Void in
    
    // 移動先の座標を指定する.
    self.rateBtn.center = CGPoint(x: self.view.frame.width/200,y: self.view.frame.height/20);
    
    }, completion: {(Bool) -> Void in
    }
    )


    //collectionViewの起動時アニメーション
    UIView.animate(withDuration: 0.4,
                   animations: {
                    self.myCollectionView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }, //戻るまでの秒数
      completion: { _ in
        UIView.animate(withDuration: 0.5) {
          self.myCollectionView.transform = CGAffineTransform.identity
        }
    })
    
    
  }//viewdidloadの閉じたぐ！
  

  
  
  
  
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
          
//          if self.userDefaults.object(forKey: "DataStore") != nil{
//            Rate = self.userDefaults.object(forKey: "DataStore") as! Int
//          }

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
   ボタンイベント(Down)
   */
  func onDownButton(sender: UIButton){
    //UIView.animateWithDuration
    UIView.animate(withDuration: 0.09,
                   
                   // アニメーション中の処理.
      animations: { () -> Void in
        
        // 縮小用アフィン行列を作成する.
        self.rateBtn.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
    })
    { (Bool) -> Void in
      
    }
  }
  
  /*
   ボタンイベント(Up)
   */
  func onUpButton(sender: UIButton){
    UIView.animate(withDuration: 2.0,
                   
                   // アニメーション中の処理.
      animations: { () -> Void in
        
        // 拡大用アフィン行列を作成する.
        self.rateBtn.transform = CGAffineTransform(scaleX: 4.0, y: 4.0)
        
        // 縮小用アフィン行列を作成する.
        self.rateBtn.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        
    })
    { (Bool) -> Void in
    
      
    }
  }
  
  
  
//  
//  /*
//   Sectionの数
//   */
//  
//  internal func numberOfSections(in collectionView: UICollectionView) -> Int {
//    return 3
//  }
//  
//
//  /**
//   セクション毎のタイトルをヘッダーに表示
//   */
//  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//    return sectionTitle[section]
//  }
//  
//  /*
//   テーブルに表示する配列の総数を返す.
//   */
//  func collectionView(_ collectionView: UICollectionView, numberOfRowsInSection section: Int) -> Int {
//    
//    // Section毎にCellの総数を変える.
//    switch(section){
//    case 0:
//      return 8
//      
//    case 1:
//      return 3
//      
//    case 2:
//      return 4
//      
//    default:
//      print("error")
//      return 0
//    }
//  }
//  
//  
//  
//  //セクションの値
//  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//    
//    let Section = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Section", for: indexPath) as! CustomCell
//    Section.sectionLabel.text? = sectionTitle[indexPath.section]
//    
//    return Section
//  }

  
  
  
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
    
    //セルのテキストを可変にする！
    cell.lblSample.adjustsFontSizeToFitWidth = true
    cell.lblSample.minimumScaleFactor = 0.8 //# //最小でも80%までしか縮小しない場合

    
    
    cell.lblSample?.text = list[indexPath.row]
    cell.imgSample?.image = UIImage(named: imageDesu[indexPath.row])
    //cell.backgroundColor = UIColor.black
    
    return cell
  }
  
  /*
   Cellが押された時
   */
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    selectedIndex = indexPath.row
    
    //セグエを指定して、画面遷移 アイデンティファイヤーの通路！
    performSegue(withIdentifier: "next", sender: nil)
    
    print("Num: \(indexPath.row)")
    print("Value:\(collectionView)")
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

