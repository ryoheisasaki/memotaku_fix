//
//  HomeViewController.swift
//  memotaku
//
//  Created by 佐々木遼平 on 2023/09/22.
//

import Foundation
import UIKit
import RealmSwift

class HomeViewController: UIViewController, UITableViewDelegate  {
    func didPostMain(mainData: MainCellModel) {
        editDataList.append(mainData)
    }
    weak var homeViewDelegate: HomeViewControllerDelegate?
    
    func reloadDataForTableView() {
        // テーブルビューを更新
        tableView.reloadData()
    }
    
    var editDataList: [MainCellModel] = []
    var editData = MainCellModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func presentedCalculator(_ sender: Any) {
        performSegue(withIdentifier: "toCalculator", sender: nil)
    }
    
    
    @IBAction func buttonSize(_ sender: UIButton) {
        // UIButtonを丸くする
            sender.layer.cornerRadius = sender.frame.size.width / 2
            sender.clipsToBounds = true

            // 他の処理も行う（遷移など）
            performSegue(withIdentifier: "toCalculator", sender: nil)
        }
    
    //セルの編集許可
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
        {
            return true
        }

        //スワイプしたセルを削除
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == UITableViewCell.EditingStyle.delete {
                let deletedData = editDataList.remove(at: indexPath.row)
                        // データベースからも削除する
                        deleteDataFromDatabase(deletedData)
                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            }
        }
    
    // データベースからデータを削除するメソッド
    func deleteDataFromDatabase(_ data: MainCellModel) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(data)
            }
        } catch {
            // エラーハンドリング
            print("Error deleting data from Realm: \(error)")
        }
    }

    // データベースからデータを読み込むメソッド
    func loadMainCellDataFromDatabase() {
        do {
            let realm = try Realm()
            let result = realm.objects(MainCellModel.self)
            // データベースから読み込む前にリストをクリア
            editDataList.removeAll()
            editDataList.append(contentsOf: result)
            tableView.reloadData()
        } catch {
            // エラーハンドリング
            print("Error loading data from Realm: \(error)")
        }
    }
    
    
    
    let realm = try! Realm() // Realmの初期化
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // カスタムセルをNibファイルから登録
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        
        // Realmからメモを読み込む
        let realm = try! Realm()
        editDataList = realm.objects(MainCellModel.self).map { $0 }
        tableView.reloadData()
    }
    
    func setSaveData() {
        let realm = try! Realm()
        let result = realm.objects(MainCellModel.self)
        editDataList = Array(result)
        
        //テーブルビュー更新
        tableView.reloadData()
    }
    
    func updateData() {
        // データを更新した後、デリゲートに通知
        homeViewDelegate?.reloadDataForTableView()
    }
    
    
}





// TwitterViewControllerのdelegateプロパティに自身を代入
//   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toCalculator" {
//            let nextView = segue.destination as! Calculator
//            nextView.delegate = self
//            nextView.editData = editCellData
//        }
//        editCellData = mainCellModel()



extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
        
        // カスタムセルの各アウトレットにデータを設定
        let memo = editDataList[indexPath.row]
        
        // DateFormatterを使用して日付を文字列に変換
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let dateString = dateFormatter.string(from: memo.date)
        cell.delegate = self //tableviewに値受け渡し
        
        cell.mainTitle.text = memo.title
        cell.mainDate.text = dateString // 日付の文字列を設定
        cell.sizeData =  memo
        return cell
    }
}

extension HomeViewController: SaveNameViewDelegate {
    func didPostSave() {
        setSaveData()
    }
    
    func didSaveNewData(newData: MainCellModel) {
        
        editDataList.append(newData)
        tableView.reloadData()
    }
    
    
}



extension HomeViewController: TableViewCellDelegate {
    func segueToCalculator(with sizeData: MainCellModel){
        
        editData = sizeData
        // 別の画面に遷移
        performSegue(withIdentifier: "toCalculator", sender: nil)
    }
    
    func segue(with sizeData: MainCellModel) {
        editData  = sizeData
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCalculator" {
            let nextView = segue.destination as! CalculatorViewController
            nextView.delegate = self
            nextView.mainCellData = editData
        }
        else if segue.identifier == "toConfirmationScreen" {
            let nextView = segue.destination as! ConfirmationScreenViewController
            nextView.delegate = self
            nextView.mainCellData = editData
        }
        
        editData = MainCellModel()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルが選択されたときに実行するコード
        let selectedCellData = editDataList[indexPath.row] // タップされたセルのデータを取得
        editData = selectedCellData // editDataに選択したセルのデータを代入
        
        // セグエを実行して画面遷移
        performSegue(withIdentifier: "toConfirmationScreen", sender: selectedCellData)
    }
}
