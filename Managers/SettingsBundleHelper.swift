//
//  SettingsBundleHelper.swift
//  RightsApp
//
//  Created by Jorge Gonzalez Conejero on 15/07/2019.
//  Copyright © 2019 uab. All rights reserved.
//

import Foundation

class SettingsBundleHelper {
    
    struct SettingsBundleKeys {
        //static let Reset = "RESET_APP_KEY"
        static let BuildVersionKey = "build_preference"
        static let AppVersionKey = "version_preference"
       /* static let EnglishKey = "english_preference"
        static let SpanishKey = "spanish_preference"
        static let ItalianKey = "italian_preference"
        static let PortugueseKey = "portuguese_preference"*/
        
    }
    
    /*class func checkAndExecuteSettings() {
        
      /* var language = LocalizationSystem.sharedInstance.getLanguage()
        let languageCodes = ["es","en","pt","it"]
        
        switch language {
        case "es":
            UserDefaults.standard.set(true, forKey: SettingsBundleKeys.SpanishKey)
        case "en":
            UserDefaults.standard.set(true, forKey: SettingsBundleKeys.EnglishKey)
        default:
            print("Something went wrong setting bundle")
        }*/
       /* if UserDefaults.standard.bool(forKey: SettingsBundleKeys.Reset) {
            UserDefaults.standard.set(false, forKey: SettingsBundleKeys.Reset)
            let appDomain: String? = Bundle.main.bundleIdentifier
            UserDefaults.standard.removePersistentDomain(forName: appDomain!)
            // reset userDefaults..
            // CoreDataDataModel().deleteAllData()
            // delete all other user data here..
        }*/
    }*/
    
    class func setVersionAndBuildNumber() {
        let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        UserDefaults.standard.set(version, forKey: "version_preference")
        let build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        UserDefaults.standard.set(build, forKey: "build_preference")
    }
}
