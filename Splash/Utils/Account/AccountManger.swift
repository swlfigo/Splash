//
//  AccountManger.swift
//  Splash
//
//  Created by Sylar on 2020/5/8.
//  Copyright © 2020 Sylar. All rights reserved.
//

import Foundation

class AccountManager {
    
    var userToken:String = ""
    var userID:String = ""
    var userAvatarURL:String = ""
    
    
    static let sharedInstance: AccountManager = {
        let instance = AccountManager()
        return instance
    }()
    
}
