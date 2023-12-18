//
//  ConfirmationScreenViewController.swift
//  memotaku
//
//  Created by 佐々木遼平 on 2023/11/01.
//

import Foundation
import RealmSwift



class ConfirmationScreenViewController: UIViewController, SaveNameViewDelegate {
    func didPostSave(){
    }
    
    weak var delegate: TableViewCellDelegate?
    
    var mainCellData = MainCellModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       updateLabels()
    }
    
    
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    var sizeData = MainCellModel()
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func save(_ sender: Any) {
        performSegue(withIdentifier: "toCalculatorEdit", sender: nil)
        if let toItemSize = mainCellData.itemSizeModel {
                let mainCellModel = MainCellModel()
                mainCellModel.itemSizeModel = toItemSize
            // mainCellData を新しい MainCellModel で更新
                    mainCellData = mainCellModel

                    // ラベルを更新
                    updateLabels()

                    delegate?.segueToCalculator(with: mainCellModel)
            
                }
            }
    func updateLabels() {
        height.text = mainCellData.itemSizeModel?.itemHeight
        thickness.text = mainCellData.itemSizeModel?.itemThickness
        width.text = mainCellData.itemSizeModel?.itemWidth
        weight.text = mainCellData.itemSizeModel?.itemWeight
        fullLength.text = mainCellData.itemSizeModel?.itemFullLength
        squareMeter.text = mainCellData.itemSizeModel?.itemSquareMeter
    }
        
        
    @IBOutlet weak var height: UILabel!
    
    @IBOutlet weak var thickness: UILabel!
    
    @IBOutlet weak var width: UILabel!
    
    @IBOutlet weak var weight: UILabel!
    
    @IBOutlet weak var fullLength: UILabel!
    
    @IBOutlet weak var squareMeter: UILabel!
    
    var itemSizeModel: ItemSizeModel? // データを格納するプロパティ
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCalculatorEdit" {
            let nextView = segue.destination as! CalculatorViewController
            nextView.delegate = self
            nextView.mainCellData = mainCellData
        }
        
    }
}
