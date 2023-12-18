    //
    //  Calculator.swift
    //  memotaku
    //
    //  Created by 佐々木遼平 on 2023/10/02.
    //

    import Foundation
    import UIKit

    class Calculator: NSObject, NSCoding {
        
        //計算結果
        private(set) var resultText: String = "0"
        //計算式
        private var expression = ""
        //現在表示している数字テキスト
        private(set) var current = ""
        
        private var progress = ""
        
        override init() {
               super.init()
           }
           
           required convenience init?(coder aDecoder: NSCoder) {
               self.init()
               if let resultText = aDecoder.decodeObject(forKey: "resultText") as? String,
                  let expression = aDecoder.decodeObject(forKey: "expression") as? String,
                  let progress = aDecoder.decodeObject(forKey: "progress") as? String {
                   self.resultText = resultText
                   self.expression = expression
                   self.progress = progress
               }
           }
           
           func encode(with aCoder: NSCoder) {
               aCoder.encode(resultText, forKey: "resultText")
               aCoder.encode(expression, forKey: "expression")
               aCoder.encode(progress, forKey: "progress")
           }
        
        
        
        func clear() {
            expression = ""
            progress = ""
            current = ""
            resultText = "0"
        }
        
        func number0(){
            number(value: 0)
        }
        
        func number1() {
            number(value: 1)
        }
        
        func number2() {
            number(value: 2)
        }
        
        func number3() {
            number(value: 3)
        }
        
        func number4() {
            number(value: 4)
        }
        
        func number5() {
            number(value: 5)
        }
        
        func number6() {
            number(value: 6)
        }
        
        func number7() {
            number(value: 7)
        }
        
        func number8() {
            number(value: 8)
        }
        
        func number9() {
            number(value: 9)
        }
        //数字を付与
        private func number(value: Int) {
               if progress.isEmpty {
                   // 演算子を入力した後に数字を入力する場合
                   expression += String(value)
               } else {
                   // 数字を連結していく場合
                   expression += String(value)
                   progress = ""
               }
               resultText = expression
           }
        //足し算
        func addition() {
            expression += "+"
            progress = ""
            current = ""
        }
        
        func subtraction() {
            expression += "-"
            progress = ""
            current = ""

        }
        
        func multiplication() {
            expression += "*"
            progress = ""
            current = ""

        }
        
        func division() {
            expression += "/"
            progress = ""
            current = ""

        }
        //小数点付与
        func decimalPoint() {
            // もし現在の数値にすでに小数点が含まれていれば、関数を終了
                guard !hasDecimal(number: current) else {
                    return
                }

                // 小数点が含まれていなければ、expressionとcurrentに追加
                expression += "."
                current += "."
            }

            // 数値に小数点が含まれているかどうかを確認する関数
            func hasDecimal(number: String) -> Bool {
                return number.contains(".")
            }
        
        func equal() {
            let result = NSExpression(format: expression.expressionWithFractionDigits).expressionValue(with: nil, context: nil)
            
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.minimumFractionDigits = 8
            
            // 少数を最低限に省略
            let trimmedResult = removeTrailingZeros(number: formatter.string(from: NSNumber(value: (result as? Double) ?? 0.0)) ?? "")
            
            resultText = trimmedResult
            
            expression = resultText
            progress = ""
           
        }
        
        /// 少数を最小限に省略するメソッド.
        func removeTrailingZeros(number: String) -> String {
            // 文字列から小数点以下の0を取り除く
            let trimmedString = number.replacingOccurrences(of: "\\.?0+$", with: "", options: .regularExpression)
            
            return trimmedString
        }
        
        /// 小数点が含まれているかどうかを判断するメソッド.
        func checkDecimal(number: String) -> Bool {
            // 小数点が含まれていればTrueを返す
            return number.contains(".")
        }
    }
    private extension String {
        var expressionWithFractionDigits: String {
            replacingOccurrences(of: "+", with: ",+,")
                .replacingOccurrences(of: "-", with: ",-,")
                .replacingOccurrences(of: "*", with: ",*,")
                .replacingOccurrences(of: "/", with: ",/,")
                .split(separator: ",")
                .map { element -> String in
                    if let doubleValue = Double(element) {
                        return String(doubleValue)
                    } else {
                        return String(element)
                    }
                }
                .joined()
        }
        
    }
