//
//  HomeViewControllerDelegate.swift
//  memotaku
//
//  Created by 佐々木遼平 on 2023/10/17.
//

import Foundation

protocol HomeViewControllerDelegate: AnyObject {
    func segueCalculator(mainData: MainCellModel)
    func reloadDataForTableView()
}
