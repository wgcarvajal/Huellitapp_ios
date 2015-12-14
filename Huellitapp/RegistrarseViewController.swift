//
//  RegistrarseViewController.swift
//  Huellitapp
//
//  Created by Aplimovil on 13/12/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import UIKit
import Parse
import Bolts

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
    
    
    @IBAction func btnregistrarse(sender: AnyObject)
    {
        let nombres = txtnombres.text
        let nameuser = txtnameuser.text
        let contrasena = txtcontrasena.text
        let repetircontrasena = txtrepetircontrasena.text
        let email = txtemail.text
        
        if (nombres!.isEmpty || nameuser!.isEmpty || contrasena!.isEmpty || repetircontrasena!.isEmpty
            || email!.isEmpty)
        {
            
            
            var myAlert = UIAlertController(title: "Campos obligatorios", message: "Todos los campos son obligatorios", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
            
        }
        
        if(contrasena != repetircontrasena)
        {
            var myAlert = UIAlertController(title: "Error", message: "Las contraseñas no coinciden", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
        }
        
        
        let myUser:PFUser = PFUser()
        myUser.username = nameuser
        myUser.password = contrasena
        myUser.email = email
        myUser.setObject(nombres!, forKey: "nombre")
        
        myUser.signUpInBackgroundWithBlock{(success: Bool, error:NSError?) -> Void in
            
            var mensaje = "Registro Exitoso"
            
            if(!success)
            {
                if(error!.code == 202)
                {
                    mensaje = "Nombre de usuario " + nameuser! + " Ya esta en uso"
                    
                }
                else
                {
                    if(error!.code == 203)
                    {
                        mensaje = "Correo electrónico Ya esta en uso"
                    }
                    else
                    {
                        mensaje = error!.localizedDescription
                    }
                }
                
            }
            
            var myAlert = UIAlertController(title: "Alerta", message: mensaje, preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default){ Action in
                
                if(success)
                {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            
                
        }
        
        
        
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
