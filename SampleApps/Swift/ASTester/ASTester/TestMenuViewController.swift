//
//  ViewController.swift
//  ASTester
//
//  Created by George Webster on 3/10/15.
//  Copyright (c) 2015 Tealium Inc. All rights reserved.
//

import UIKit

enum MenuItems: Int {
    case SendEventLink = 0
    case SendEventView
    case FetchProfile
    case LogLastProfile
    case NumberOfItems
}

class TestMenuViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: UITableViewDatasource

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MenuItems.NumberOfItems.rawValue
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("ASMenuCellIdentifier") as! UITableViewCell
        
        if let menuItem = MenuItems(rawValue: indexPath.row) {
            
            switch menuItem {
                
            case .SendEventLink:
                cell.textLabel?.text = "Send Track Link Event"
                
            case .SendEventView:
                cell.textLabel?.text = "Send Track View Event"
                
            case .FetchProfile:
                cell.textLabel?.text = "Fetch Current Profile"
            
            case .LogLastProfile:
                cell.textLabel?.text = "Log Last Loaded Profile"
                
            default:
                println("un supported menu item")
            }
        }
        
        return cell
    }
    
    // MARK: UITableViewDelegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let menuItem = MenuItems(rawValue: indexPath.row) {
            
            switch menuItem {
                
            case .SendEventLink:
                sendAudienceStreamLinkEvent()
                
            case .SendEventView:
                sendAudienceStreamViewEvent()
                
            case .FetchProfile:
                fetchAudienceStreamProfile()
                
            case .LogLastProfile:
                accessLastLoadedAudienceStreamProfile()
                
            default:
                println("un supported menu item")
            }
        }
    }
    
    
    func sendAudienceStreamViewEvent() {
        
        let data: [String: String] = [ "event_name" : "m_view" ]
        
        TEALAudienceStream.send
    }
    
    func sendAudienceStreamLinkEvent() {

        let data: [String: String] = [ "event_name" : "m_link" ]
        
        TEALAudienceStream.sendEvent(TEALEventType.Link, withData: data)
    }
    
    func fetchAudienceStreamProfile() {
        
        TEALAudienceStream.fetchProfileWithCompletion { (profile, error) -> Void in
            
            if (error != nil) {
                println("test app failed to receive profile with error: \(error.localizedDescription)")
            } else {
                println("test app received profile: \(profile)")
            }
        }
    }
    
    func accessLastLoadedAudienceStreamProfile() {
        
        if let profile:TEALProfile = TEALAudienceStream.cachedProfileCopy() {
            println("last loaded profile: \(profile)")
        } else {
            println("a valid profile has not been received yet.")
        }
    }
    
    func presentTraceInputView() {
    
    }
    
    func joinTraceWithToken( token:String ) {
    
        TEALAudienceStream.joinTraceWithToken(token)
    }

    func leaveTrace() {
        
        TEALAudienceStream.leaveTrace()
    }
}


