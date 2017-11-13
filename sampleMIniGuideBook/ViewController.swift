//
//  ViewController.swift
//  sampleMIniGuideBook
//
//  Created by 加藤　大起 on 2017/11/12.
//  Copyright © 2017年 Taiki Kato. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    var areaList:[String] = []
    
    //選択されたエリア名を保存するメンバ変数
    var selectedPlace:String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "セブ一覧"
        
        //ファイルパスを取得（エリア名が格納されているプロパティリスト）
        let filePath = Bundle.main.path(forResource: "areaList", ofType: "plist")
        
        //ファイルの内容を読み込んでディクショナリー型に格納
        let dic = NSDictionary(contentsOfFile: filePath!)
        
        //TableViewで扱いやすい配列の形（エリア名の入ってる配列）を作成
        for (key, data) in dic! {
            print(key)
            areaList.append(key as! String)
        }
        
    }
    
    //2.行数決定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areaList.count
    }
    
    //3.表示する文字列を決定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //文字列を表示するセルの取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //文字色を青にする
        cell.textLabel?.textColor = UIColor.blue
        
        //表示したい文字の設定
        cell.textLabel?.text = areaList[indexPath.row]
        
        //文字を設定したセルを返す
        return cell
    }
    
    //選択された行取得(タップされたとき)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\((indexPath as NSIndexPath).row)行目選択")
        //タップされた行のエリア名を保存
        selectedPlace = areaList[(indexPath as NSIndexPath).row] as String
        //セグエのidentifierを指定して、画面移動
        performSegue(withIdentifier: "showDetail",sender: nil)
    }
    
    //セグエに入れてDetailに飛ばす
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面のインスタンスを取得
        let toDetail = segue.destination as! DetailViewController
        //次の画面のプロパティにタップされた行のエリア名を渡す
        toDetail.movedPlace = selectedPlace
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
