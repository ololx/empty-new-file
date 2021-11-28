//
//  ExtensionScaner.swift
//  empty-new-file
//
//  Created by Alexander A. Kropotin on 03/11/2021.
//  Copyright © 2021 Alexander A. Kropotin. All rights reserved.
//

import Foundation
import FinderSync

public extension Sequence where Element: Hashable {
    func unique() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value);
            }
        }
        
        return result;
    }
}

public struct UTTypeConformsTo: Codable {
    var typeConformsTo: [String]?
    var iconConformsTo: String?
    
    private enum CodingKeys : String, CodingKey {
        case typeConformsTo = "CFBundleTypeExtensions"
        case iconConformsTo = "CFBundleTypeIconFile"
    }
}

public struct Info: Codable {
    var exportedTypeDeclarations: [UTTypeConformsTo]?
    
    private enum CodingKeys : String, CodingKey {
        case exportedTypeDeclarations = "CFBundleDocumentTypes"
    }
}

public protocol ExtentionsScanner {
    
    func scan() -> [String]!;
}

public class AppExtentionsScanner: ExtentionsScanner {
    
    public func scan() -> [String]! {
        let applicationsDirectory = FileManager.default.urls(for: .applicationDirectory, in: .localDomainMask)[0];
        var extentions: [String] = [];
        var icns: [String: String] = [:];
        
        do {
            let apps = try FileManager.default.contentsOfDirectory(at: applicationsDirectory, includingPropertiesForKeys: nil);
            
            for app in apps {
                do {
                    let infoPlistData = try Data(contentsOf: app.appendingPathComponent("Contents").appendingPathComponent("Info.plist"));
                    let infoData: Info? = try PropertyListDecoder().decode(Info.self, from: infoPlistData);
                    
                    if (infoData != nil && infoData?.exportedTypeDeclarations != nil) {
                        for exportedTypeDeclaration in (infoData?.exportedTypeDeclarations!)! {
                            if (exportedTypeDeclaration.typeConformsTo == nil) {
                                continue;
                            }
                            
                            for extensionName in exportedTypeDeclaration.typeConformsTo! {
                                if (exportedTypeDeclaration.iconConformsTo == nil) {
                                    continue;
                                }
                                
                                var iconName = exportedTypeDeclaration.iconConformsTo!;
                                if (!iconName.contains(".icns")) {
                                    iconName.append(".icns");
                                }
                                
                                let filename = app.appendingPathComponent("Contents").appendingPathComponent("Resources").appendingPathComponent(iconName);
                                if(!FileManager.default.fileExists(atPath: filename.path)) {
                                    continue;
                                }
                                
                                icns.updateValue(filename.absoluteString, forKey: extensionName.lowercased());
                                extentions.append(extensionName.lowercased());
                            }
                        }
                    }
                } catch let error as NSError {
                    NSLog("ExtensionScanner.scan() failed to scan apps: %@", error.description as NSString);
                }
            }
            extentions = extentions.unique().sorted();
        } catch let error as NSError {
            NSLog("ExtensionScanner.scan() failed to scan apps: %@", error.description as NSString);
        }
        
        EmptyNewFileExtension.incs = icns;
        
        return extentions;
    }
}
