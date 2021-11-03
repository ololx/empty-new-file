//
//  EmptyNewFileDefaults.swift
//  empty-new-file
//
//  Created by Alexander A. Kropotin on 03/11/2021.
//  Copyright © 2021 Alexander A. Kropotin. All rights reserved.
//

import Foundation

public struct EmptyNewFileDefaults<T> {
    
    var key: String
    
    var defaultValue: T
}

public extension EmptyNewFileDefaults {
    
    func get() -> T {
        guard let valueUntyped = UserDefaults.init(suiteName: "org.ololx.EmptyNewFile")?.object(forKey: self.key) else {
            return self.defaultValue;
        }
        
        guard let value = valueUntyped as? T else {
            return self.defaultValue;
        }
        
        return value;
    }
    
    func set(_ value: T) {
        UserDefaults.init(suiteName: "org.ololx.EmptyNewFile")?.set(value, forKey: self.key);
    }
}

public enum EmptyNewFileExtension {
    
    static var extensions: [String] {
        get {
            return extensionsDefaults.get();
            
        }
        set {
            extensionsDefaults.set(newValue);
            
        }
    }
    
    private static var extensionsDefaults = EmptyNewFileDefaults(key: "extensions", defaultValue: ["js", "css", "html", "md"]);
}
