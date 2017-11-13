//
//  DetailViewController.swift
//  sampleMIniGuideBook
//
//  Created by 加藤　大起 on 2017/11/12.
//  Copyright © 2017年 Taiki Kato. All rights reserved.
//

import UIKit
import MapKit


class DetailViewController: UIViewController {

    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myMapView: MKMapView!
    
    var movedPlace:String = ""
    
    override func viewDidLoad() {
        
        //タイトルをナビゲーションバーに表示
        
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        myTextView.backgroundColor = UIColor.black
        myTextView.textColor = UIColor.white
        //値の受取確認
        print(movedPlace)
        myLabel.text = movedPlace
        
        
        //ファイルパス取得
        let filePath = Bundle.main.path(forResource: "areaList", ofType: "plist")
        
        //ファイル読み込み && Dic型に代入
        let dic = NSDictionary(contentsOfFile: filePath!)
        //(今画面に表示したいデータの取得)
        //let detailnfo = dic![getName] as! NSDictionary
        
        // plistデータをDic型に変換
        for(key,data) in dic!{
            let dicData:NSDictionary = data as! NSDictionary
            if((key as! String) as String == movedPlace){
                navigationItem.title = movedPlace
                //説明文代入
                myTextView.text = dicData["description"] as! String
                //画像代入
                myImageView.image = UIImage(named:dicData["image"] as! String)
                
                
                //緯度代入
                let latitude:String = dicData["latitude"] as! String
                //経度代入
                let longitude:String = dicData["longitude"] as! String
                //中心定義
                //型変換　String->Double型
                let coordinate = CLLocationCoordinate2DMake(atof(latitude), atof(longitude))
                //縮尺定義
                let span = MKCoordinateSpanMake(0.1, 0.1)
                //範囲object
                let region = MKCoordinateRegionMake(coordinate, span)
                //マップ表示
                myMapView.setRegion(region, animated:true)
                // ピン定義
                let myPin: MKPointAnnotation = MKPointAnnotation()
                // 座標決め
                myPin.coordinate = coordinate
                // pinタイトル
                myPin.title = movedPlace
                // pinサブタイトル
                myPin.subtitle = "セブで熱い場所"
                // マップにピン表示
                myMapView.addAnnotation(myPin)
            }
            
        }
        
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
