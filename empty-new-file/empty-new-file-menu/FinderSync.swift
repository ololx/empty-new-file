//
//  FinderSync.swift
//  empty-new-file-menu
//
//  Created by Alexander A. Kropotin on 03/11/2021.
//  Copyright © 2021 Alexander A. Kropotin. All rights reserved.
//

import Cocoa
import FinderSync

class FinderSync: FIFinderSync {

    override init() {
        super.init()
        
        NSLog("FinderSync() launched from %@", Bundle.main.bundlePath as NSString)
        
        let finderSync = FIFinderSyncController.default();
        
        if let mountedVolumes = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: nil,
                                                                      options: .skipHiddenVolumes) {
            finderSync.directoryURLs = Set<URL>(mountedVolumes);
        }
        
        let notificationCenter = NSWorkspace.shared.notificationCenter
        notificationCenter.addObserver(forName: NSWorkspace.didMountNotification, object: nil, queue: .main) {
            (notification) in
            if let volumeURL = notification.userInfo?[NSWorkspace.volumeURLUserInfoKey] as? URL {
                finderSync.directoryURLs.insert(volumeURL);
            }
        }
    }
    
    // MARK: - Primary Finder Sync protocol methods
    
    override func beginObservingDirectory(at url: URL) {
        // The user is now seeing the container's contents.
        // If they see it in more than one view at a time, we're only told once.
        NSLog("beginObservingDirectoryAtURL: %@", url.path as NSString)
    }
    
    
    override func endObservingDirectory(at url: URL) {
        // The user is no longer seeing the container's contents.
        NSLog("endObservingDirectoryAtURL: %@", url.path as NSString)
    }
    
    override func menu(for menuKind: FIMenuKind) -> NSMenu {
        // Produce a menu for the extension (to be shown when right clicking a folder in Finder)
        let emptyBlankFileMenu = NSMenu(title: "");
        emptyBlankFileMenu.setAccessibilityIndex(0);
        
        let exts = EmptyNewFileExtension.extensions;
        let icns = EmptyNewFileExtension.incs;
        for ext in exts {
            let item = NSMenuItem.init();
            item.title = "\(ext.value)";
            item.action = #selector(createSymlink(_:));
            item.target = self
            
            if (icns["\(ext.key)"] != nil) {
                item.image = NSImage.init(byReferencing: URL.init(string: icns[ext.key]!)!)
            }
            
            emptyBlankFileMenu.addItem(item);
        }
        
        
        
        let emptyBlankFileMainMenu = NSMenu(title: "");
        let emptyBlankFileMenuItem = NSMenuItem(
            title:  NSLocalizedString("NEW_FILE_ACTION_NAME", comment: ""),
            action: nil,
            keyEquivalent: ""
        );
        emptyBlankFileMainMenu.setSubmenu(emptyBlankFileMenu, for: emptyBlankFileMenuItem);
        emptyBlankFileMainMenu.addItem(emptyBlankFileMenuItem);
        return emptyBlankFileMainMenu;
    }
    
    @IBAction func createSymlink(_ sender: NSMenuItem!) {
        guard let target = FIFinderSyncController.default().targetedURL() else {
            
            NSLog("Failed to obtain targeted URL: %@")
            
            return
        }
        
        var originalPath = target
        let originalFilename = NSLocalizedString("NEW_FILE_ACTION_NAME", comment: "")
        var filename = "\(originalFilename).\(sender.title)"
        let fileType = ".\(sender.title)"
        var counter = 1
        
        while FileManager.default.fileExists(atPath: originalPath.appendingPathComponent(filename).path) {
            filename = "\(originalFilename)\(counter)\(fileType)"
            counter+=1
            originalPath = target
        }
        
        do {
            try "".write(to: target.appendingPathComponent(filename), atomically: true, encoding: String.Encoding.utf8)
        } catch let error as NSError {
            
            NSLog("Failed to create file: %@", error.description as NSString)
        }
    }
    
    private func loadImage(filePath: String) -> NSImage? {
        let fileURL = URL.init(string: filePath);
        do {
            let imageData = try Data(contentsOf: fileURL!)
            return NSImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
}

