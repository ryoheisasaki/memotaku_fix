//
//  CalculatorViewController.swift
//  memotaku
//
//  Created by 佐々木遼平 on 2023/10/10.
//

import Foundation
import UIKit
import RealmSwift

class CalculatorViewController: UIViewController, SaveNameViewDelegate {
    func didPostSave() {
    }
    weak var confirmationScreenViewController: ConfirmationScreenViewController?
        
    // デリゲートプロパティ
    weak var saveDelegate: TableViewCellDelegate?
    
    // ItemSizeModel プロパティ
    var itemSizeModel: ItemSizeModel?
    
    weak var delegate: SaveNameViewDelegate?
    
    var mainCellData = MainCellModel()
    
    
    private let calculator = Calculator()
    
    //各ラベル等の実装
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    let realm = try! Realm() //Realm初期化
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        //DismissKeyboard
        setDismissKeyboard()
        
        //mainCellから受け渡し
        itemHeightField.text = mainCellData.itemSizeModel?.itemHeight
        itemWidthField.text = mainCellData.itemSizeModel?.itemWidth
        itemWeightField.text = mainCellData.itemSizeModel?.itemWeight
        itemThicknessField.text = mainCellData.itemSizeModel?.itemThickness
        itemFullLengthField.text = mainCellData.itemSizeModel?.itemFullLength
        itemSquareMeterField.text = mainCellData.itemSizeModel?.itemSquareMeter

        
        }
    
    
    
    
    @IBAction func presentedSaveName(_ sender: Any) {
        performSegue(withIdentifier: "toSaveName", sender: nil)
    }
    
    
    //電卓機能
    @IBAction func clear(_ sender: Any) {
        calculator.clear()
        resultLabel.text = calculator.resultText
    }
    
    
    @IBAction func number0(_ sender: Any) {
        calculator.number0()
        resultLabel.text = calculator.resultText
    }
    
    @IBAction func number1(_ sender: Any) {
        calculator.number1()
        resultLabel.text = calculator.resultText
    }
    
    @IBAction func number2(_ sender: Any) {
        calculator.number2()
        resultLabel.text = calculator.resultText
    }
    
    @IBAction func number3(_ sender: Any) {
        calculator.number3()
        resultLabel.text = calculator.resultText
    }
    
    @IBAction func number4(_ sender: Any) {
        calculator.number4()
        resultLabel.text = calculator.resultText
    }
    
    @IBAction func number5(_ sender: Any) {
        calculator.number5()
        resultLabel.text = calculator.resultText
    }
    
    @IBAction func number6(_ sender: Any) {
        calculator.number6()
        resultLabel.text = calculator.resultText
    }
    
    @IBAction func number7(_ sender: Any) {
        calculator.number7()
        resultLabel.text = calculator.resultText
    }
    
    @IBAction func number8(_ sender: Any) {
        calculator.number8()
        resultLabel.text = calculator.resultText
    }
    
    @IBAction func number9(_ sender: Any) {
        calculator.number9()
        resultLabel.text = calculator.resultText
    }
    
    @IBAction func equal(_ sender: Any) {
        calculator.equal()
        resultLabel.text = calculator.resultText
    }
    
    @IBAction func add(_ sender: Any) {
        calculator.addition()
        resultLabel.text = calculator.resultText
    }
    
    @IBAction func sub(_ sender: Any) {
        calculator.subtraction()
        resultLabel.text = calculator.resultText
    }
    
    @IBAction func mult(_ sender: Any) {
        calculator.multiplication()
        resultLabel.text = calculator.resultText
    }
    
    @IBAction func div(_ sender: Any) {
        calculator.division()
        resultLabel.text = calculator.resultText
    }
    
    
    @IBAction func decimal(_ sender: Any) {
        calculator.decimalPoint()
        resultLabel.text = calculator.resultText
    }
    
    
    //各サイズ
    
    
    @IBOutlet weak var itemHeightField: UITextField!
    
    @IBOutlet weak var itemWidthField: UITextField!
    
    @IBOutlet weak var itemFullLengthField: UITextField!
    
    @IBOutlet weak var itemThicknessField: UITextField!
    
    @IBOutlet weak var itemWeightField: UITextField!
    
    @IBOutlet weak var itemSquareMeterField: UITextField!
    
    
    //保存する値
    func itemSave() -> ItemSizeModel {
        let itemSize = ItemSizeModel()
        //渡すデータ
        itemSize.itemHeight = itemHeightField.text ?? "0.0"
        itemSize.itemWidth = itemWidthField.text ?? "0.0"
        itemSize.itemFullLength = itemFullLengthField.text ?? "0.0"
        itemSize.itemThickness = itemThicknessField.text ?? "0.0"
        itemSize.itemWeight = itemWeightField.text ?? "0.0"
        itemSize.itemSquareMeter =  itemSquareMeterField.text ?? "0.0"
        
        return itemSize
    }
    
    //値の受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSaveName" {
            let nextView = segue.destination as! SaveNameViewController
            nextView.saveDelegate = delegate
            nextView.itemSizeData = itemSave()
            nextView.mainCellData = mainCellData
            
            
        }
    }
}
