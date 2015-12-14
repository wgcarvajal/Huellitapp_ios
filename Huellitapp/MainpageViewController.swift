//
//  MainpageViewController.swift
//  Huellitapp
//
//  Created by Aplimovil on 14/12/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import UIKit
import Parse
import Bolts

class MainpageViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCerrarSession(sender: AnyObject)
    {
        
        
        PFUser.logOutInBackground()
        
        let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
        
        var viewPage:ViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        
        var viewPageNav = UINavigationController(rootViewController: viewPage)
        
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = viewPageNav
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
