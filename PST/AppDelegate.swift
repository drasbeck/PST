//
//  AppDelegate.swift
//  PST
//
//  Created by Max Drasbeck on 23/09/2016.
//  Copyright © 2016 Max Drasbeck. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    let statusItem = NSStatusBar.system().statusItem(withLength: -2)
    
    let popover = NSPopover()
    
    func showPreferences(sender: AnyObject) {
        // placeholder for an actual preferences screen
        let quoteText = "Success is not final, failure is not fatal: it is the courage to continue that counts."
        let quoteAuthor = "Winston Churchill"
        
        print("\(quoteText) - \(quoteAuthor)")
    }
    
    
    // ping graphics
    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
    }
    
    func togglePopover(sender: AnyObject?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    // left click invokes ping graphics
    func leftClickAction(leftClick: NSGestureRecognizer) {
        if let button = leftClick.view as? NSButton {
            togglePopover(sender: self)
        }
    }

    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        popover.contentViewController = PSTViewController(nibName: "PSTViewController", bundle: nil)        
        
        if let button = statusItem.button {
            button.image = NSImage(named: "StatusBarButtonImage")
            
            // left click functionality
            let leftClick = NSClickGestureRecognizer()
            leftClick.buttonMask = 0x1 // right mouse
            leftClick.numberOfClicksRequired = 1
            leftClick.target = self
            leftClick.action = #selector(leftClickAction)
            button.addGestureRecognizer(leftClick)
        }
        
        
        // Menu interface
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Preferences", action: #selector(showPreferences), keyEquivalent: ","))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit PST", action: #selector(quit), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
    
    func quit(sender: NSMenuItem) {
        NSApp.terminate(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

