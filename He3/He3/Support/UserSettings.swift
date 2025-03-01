//
//  UserSettings.swift
//  He3 (Helium 3)
//
//  Created by Christian Hoffmann on 10/31/15.
//  Copyright © 2015 Jaden Geller. All rights reserved.
//  Copyright © 2017-2020 CD M Santiago. All rights reserved.
//

import Foundation

internal struct UserSettings {
    internal class Setting<T> {
        private let key: String
        private let defaultValue: T
        
        init(_ userDefaultsKey: String, defaultValue: T) {
            self.key = userDefaultsKey
            self.defaultValue = defaultValue
        }
        
        var keyPath: String {
            get {
                return self.key
            }
        }
        var `default`: T {
            get {
                return self.defaultValue
            }
            set (value) {
                self.set(value)
            }
        }
        var value: T {
            get {
                return self.get()
            }
            set (value) {
                self.set(value)
                //  Inform all interested parties
                NotificationCenter.default.post(name: Notification.Name(rawValue: self.keyPath), object: nil)
            }
        }
        
        private func get() -> T {
            if let value = UserDefaults.standard.object(forKey: self.key) as? T {
                return value
            } else {
                // Sets default value if failed
                set(self.defaultValue)
                return self.defaultValue
            }
        }
        
        private func set(_ value: T) {
            UserDefaults.standard.set(value as Any, forKey: self.key)
        }
    }
    
    //  Global Defaults keys
    static let DisabledMagicURLs = Setting<Bool>("disabledMagicURLs", defaultValue: false)
    static let PlaylistThrottle = Setting<Int>("playlistThrottle", defaultValue: 32)

    static let HomePageURL = Setting<String>(
        "homePageURL",
        defaultValue: "https://slashlos.github.io/He3/he3_start.html"
    )
    static let HomeStrkURL = Setting<String>(
        "homeStrkURL",
        defaultValue: "https://slashlos.github.io/He3/he3_stark.html"
    )
    static let HelpPageURL = Setting<String>(
        "helpPageURL",
        defaultValue: "https://slashlos.github.io/He3/Help/index.html"
    )
    static let HomePageName = Setting<String>("homePageName", defaultValue: "he3_start")
    
    //  NOTE: UserAgent default is loaded at run-time
    static let UserAgent = Setting<String>("userAgent", defaultValue:
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.5 Safari/605.1.15")

    //  Snapshots path loading once
    static let SnapshotsURL = Setting<String>("snapshotsURL", defaultValue: "")

    //  User Defaults keys
    static let HistoryName  = Setting<String>("historyName", defaultValue:"History")
    static let HistoryKeep  = Setting<Int>("historyKeep", defaultValue:2048)
    static let HistoryList  = Setting<String>("historyList", defaultValue:"histories")
    static let HistorySaves = Setting<Bool>("historySaves", defaultValue: true)
    static let HideAppMenu  = Setting<Bool>("hideAppMenu", defaultValue: false)
    static let AutoHideTitle = Setting<Bool>("autoHideTitle", defaultValue: true)
    static let AutoSaveDocs = Setting<Bool>("autoSaveDocs", defaultValue: true)
    static let AutoSaveTime = Setting<TimeInterval>("autoSaveTimeSeconds", defaultValue: 10.0)
    static let PromoteHTTPS = Setting<Bool>("promoteHTTPS", defaultValue: true)
    static let RestoreDocAttrs = Setting<Bool>("restoreDocAttrs", defaultValue: true)
    static let RestoreWebURLs = Setting<Bool>("restoreWebURLs", defaultValue: true)
    static let RestoreLocationSvcs = Setting<Bool>("restoreLocationSvcs", defaultValue: true)
    static let AcceptWebCookie = Setting<Bool>("acceptWebCookie", defaultValue: true)
    static let ShareWebCookies = Setting<Bool>("shareWebCookies", defaultValue: true)
    static let StoreWebCookies = Setting<Bool>("storeWebCookies", defaultValue: true)

    //  User non-document windows to restore
    static let KeepListName = Setting<String>("keepList", defaultValue: "Keep")
    
    //  Search provider - must match k struct, menu item tags
    static let Search = Setting<Int>("search", defaultValue: 1) // DuckDuckGo
    static let SearchNames = Setting<String>("webSearches", defaultValue: "WebSearches")
    static let SearchKeep  = Setting<Int>("searchKeep", defaultValue:255)

    //  Developer setting(s)
    static let DeveloperExtrasEnabled = Setting<Bool>("developerExtrasEnabled", defaultValue: false)
	
	//	Login Auto Start
	static let LoginAutoStartAtLaunch = Setting<Bool>("loginAutoStartAtLaunch", defaultValue: false)
}
