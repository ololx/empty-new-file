//
//  ViewController.swift
//  quick-blank-file
//
//  Created by Alexander A. Kropotin on 31/10/2021.
//  Copyright © 2021 Alexander A. Kropotin. All rights reserved.
//

import Cocoa

import Foundation
import FinderSync

struct UTTypeConformsTo: Codable {
    var typeConformsTo: [String]?
    
    private enum CodingKeys : String, CodingKey {
        case typeConformsTo = "CFBundleTypeExtensions"
    }
}

struct Info: Codable {
    var exportedTypeDeclarations: [UTTypeConformsTo]?
    
    private enum CodingKeys : String, CodingKey {
        case exportedTypeDeclarations = "CFBundleDocumentTypes"
    }
}

class ViewController: NSViewController {
    

    @IBOutlet weak var HH: NSScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //HH.stringValue = "";
        
        let paths = FileManager.default.urls(for: .applicationDirectory, in: .localDomainMask)[0];
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: paths, includingPropertiesForKeys: nil)
            
            var exts = [""];
            for subPath in fileURLs {
                
                var config: Info?
                let decoder = PropertyListDecoder()
                do {
                    let infoPlistData = try Data(contentsOf: subPath.appendingPathComponent("Contents").appendingPathComponent("Info.plist"))
                    config = try decoder.decode(Info.self, from: infoPlistData)
                    print(config?.exportedTypeDeclarations?[0].typeConformsTo)
                    
                    var xxts = [""];
                    if (config != nil && config?.exportedTypeDeclarations != nil) {
                        for xxxts in (config?.exportedTypeDeclarations)! {
                            if (xxxts.typeConformsTo != nil) {
                                xxts = xxxts.typeConformsTo!;
                                for fff in xxts {
                                    exts.append(".\(fff)")
                                }
                            }
                        }
                    }
                
                } catch {
                    print(error)
                }
            }
            
            let documentView = NSView(frame: CGRect(x: 0, y: 0, width: Int(self.HH.bounds.width), height: 20 * (exts.count - 1)))
            var i = -1;
            for ext in exts {
                let vertSpacing = CGFloat(i * 20)
                i = i + 1;
                let checkbox = NSButton.init();
                checkbox.title = ext;
                checkbox.setButtonType(NSButton.ButtonType.switch)
                checkbox.target = self;
                
                checkbox.frame = CGRect(x: 0, y: vertSpacing, width: self.HH.bounds.width, height: 20)
                documentView.addSubview(checkbox);
            }
            
            self.HH.documentView = documentView
            //self.HH.addSubview(documentView)
        } catch let error as NSError {
            NSLog("FileManager.createSymbolicLink() failed to create file: %@", error.description as NSString);
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

