//
//  ViewController.swift
//  empty-new-file
//
//  Created by Alexander A. Kropotin on 03/11/2021.
//  Copyright © 2021 Alexander A. Kropotin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var extensionsView: NSScrollView!;
    
    private var extensionsCheckboxes: [NSButton] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad();

        let extensions: [String] = AppExtentionsScanner.init().scan();
        let extensionsCheckboxesView = NSView(frame: CGRect(x: 0, y: 0, width: Int(self.extensionsView.bounds.width), height: 20 * (extensions.count - 1)));
        
        for i in 0 ... extensions.count - 1 {
            let checkbox = NSButton.init();
            checkbox.title = extensions[i];
            checkbox.setButtonType(NSButton.ButtonType.switch);
            checkbox.target = self;
            
            checkbox.frame = CGRect(x: 0, y: CGFloat(i * 20), width: self.extensionsView.bounds.width, height: 20);
            extensionsCheckboxesView.addSubview(checkbox);
            self.extensionsCheckboxes.append(checkbox);
        }
        
        self.extensionsView.documentView = extensionsCheckboxesView;
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func saveExtensions(_ sender: Any) {
        var extensions: [String: String] = [:];
        
        for checkbutton in self.extensionsCheckboxes {
            if (checkbutton.state == .on) {
                extensions.updateValue(checkbutton.title, forKey: checkbutton.title);
            }
        }
        
        EmptyNewFileExtension.extensions = extensions;
    }
}

