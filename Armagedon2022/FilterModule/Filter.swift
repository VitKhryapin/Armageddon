//
//  SaveFilter.swift
//  Armagedon2022
//
//  Created by Vitaly Khryapin on 27.04.2022.
//

import Foundation

enum KeysUserDefaults {
    static let settingsFilter = "settingsFilter"
}

class Filter {
    static var shared = Filter()
    private let defaultSettings = SettingsFilter(unit: 0, importance: false)
    var currentSettings: SettingsFilter{
        get{
            if let data = UserDefaults.standard.object(forKey: KeysUserDefaults.settingsFilter) as? Data{
                return try! PropertyListDecoder().decode(SettingsFilter.self, from: data)
            }else{
                if let data = try? PropertyListEncoder().encode(defaultSettings){
                    UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.settingsFilter)
                }
                return defaultSettings
            }
        }
        set{
            if let data = try? PropertyListEncoder().encode(newValue){
                UserDefaults.standard.setValue(data, forKey: KeysUserDefaults.settingsFilter)
            }
        }
    }
}

