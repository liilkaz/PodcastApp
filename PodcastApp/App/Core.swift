//
//  Core.swift
//  PodcastApp
//
//  Created by Лилия Феодотова on 08.10.2023.
//

import Foundation

class Core{
    
    static let shared = Core()
    
    func isNewUser() -> Bool{
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func notNewUser(){
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
