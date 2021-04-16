//
//  ViewController.swift
//  BCryptSwiftSample
//
//  Created by Kazunori Aoki on 2021/04/16.
//

import UIKit
import BCryptSwift

class ViewController: UIViewController {
    
    let password: String = "hogehoge1234"

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Password: " + password)
        
        // ラウンド数を指定してsaltを作成する
        let roundTimes: UInt = 22
        let targetRoundSalt = BCryptSwift.generateSaltWithNumberOfRounds(roundTimes)
        print("Target Round Salt: " + targetRoundSalt)
        
        // ラウンド数を指定しないでsaltを作る（固定値で10）
        let notTargetRoundSalt = BCryptSwift.generateSalt()
        print("Not Target Round Salt: " + notTargetRoundSalt)
        
        // パスワードのhash化
        let roundHash = BCryptSwift.hashPassword(password, withSalt: targetRoundSalt)
        if let roundHashString = roundHash {
            print("Round Hash Password: " + roundHashString)
        } else {
            print("faild hash password 1")
        }
        
        let notRoundHash = BCryptSwift.hashPassword(password, withSalt: notTargetRoundSalt)
        if let notRoundHashString = notRoundHash {
            print("Not Round Hash Password: " + notRoundHashString)
        } else {
            print("faild hash password 2")
        }
        
        // パスワードのVerify
        let roundHashVerifyPW = BCryptSwift.verifyPassword(roundHash!, matchesHash: targetRoundSalt)
        print("Round Verify PW: " + String(roundHashVerifyPW!))

        let notRoundHashVerifyPW = BCryptSwift.verifyPassword(notRoundHash!, matchesHash: targetRoundSalt)
        print("Not Round Verify PW; " + String(notRoundHashVerifyPW!))
    }
}
