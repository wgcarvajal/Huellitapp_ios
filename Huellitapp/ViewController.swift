//
//  ViewController.swift
//  Huellitapp
//
//  Created by Aplimovil on 13/12/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import UIKit
import Parse
import Bolts

class ViewController: UIViewController {

    
    @IBOutlet var txtnameuser: UITextField!
    @IBOutlet var txtpass: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btningresar(sender: AnyObject)
    {
        let nameUser = txtnameuser.text
        let pass = txtpass.text
        
        if nameUser == "" && pass == ""        {
            
            var alert = UIAlertView(title: "Campos obligatorios", message: "Ingrese nombre de usuario y contraseña ", delegate: self, cancelButtonTitle: "Aceptar")
            alert.show()
        }
        else
        {
            if pass == ""
            {
                
                var alert = UIAlertView(title: "Campo obligatorio", message: "Ingrese contraseña", delegate: self, cancelButtonTitle: "Aceptar")
                alert.show()
            }
            else
            {
                if nameUser == ""
                {
                    
                    var alert = UIAlertView(title: "Campo obligatorio", message: "Ingrese nombre de usuario", delegate: self, cancelButtonTitle: "Aceptar")
                    alert.show()
                }
                
                else
                {
                    PFUser.logInWithUsernameInBackground(nameUser!, password:pass!)
                    {
                        (user: PFUser?, error: NSError?) -> Void in
                        if user != nil
                        {
                            // Do stuff after successful login.
                            let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Main", bundle: nil)
                            
                            var mainPage:MainpageViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("MainpageViewController") as! MainpageViewController
                            
                            var mainPageNav = UINavigationController(rootViewController: mainPage)
                            
                            var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                            
                            appDelegate.window?.rootViewController = mainPageNav
                            
                            
                        } else
                        {
                            var alert = UIAlertView(title: "Campo incorrectos", message: "Nombre de usuario o contraseña incorrectos", delegate: self, cancelButtonTitle: "Aceptar")
                            alert.show()
                        }
                    }
                }
            }
            
        }
        
        
        
        
        
        
        
        
            
    }


}

