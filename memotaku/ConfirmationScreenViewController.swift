//
//  ConfirmationScreen.swift
//  memotaku
//
//  Created by 佐々木遼平 on 2023/11/01.
//

import Foundation
import RealmSwift

class ConfirmationScreen: UIViewController {
    func didPostSave(){
    }
    
    weak var delegate: SaveNameViewDelegate?
    
    var mainCellData = MainCellModel()
}
