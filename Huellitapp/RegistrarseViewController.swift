//
//  RegistrarseViewController.swift
//  Huellitapp
//
//  Created by Aplimovil on 13/12/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import UIKit

class RegistrarseViewController: UIViewController
{

    @IBOutlet var txtnombres: UITextField!
    @IBOutlet var txtnameuser: UITextField!
    @IBOutlet var txtcontrasena: UITextField!
    @IBOutlet var txtrepetircontrasena: UITextField!
    @IBOutlet var txtemail: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func btnregistrarse(sender: AnyObject)
    {
        
        
    }
    
    
    

}
