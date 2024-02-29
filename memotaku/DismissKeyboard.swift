//
//  DismissKeyboard.swift
//  memotaku
//
//  Created by 佐々木遼平 on 2023/10/01.
//

import UIKit

extension UIViewController {

    //キーボードを閉じる
    func setDismissKeyboard() {
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGR.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGR)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
