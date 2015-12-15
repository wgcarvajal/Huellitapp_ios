//
//  MensajeInteresadoViewController.swift
//  Huellitapp
//
//  Created by Aplimovil on 15/12/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import UIKit
import Parse
import Bolts

class MensajeInteresadoViewController: UIViewController {

    @IBOutlet var mensajesTextView: UITextView!
    @IBOutlet var txtmensaje: UITextField!
    
    
     var mascota:PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mensajesTextView.text = ""
        
        let currentuser = PFUser.currentUser()?.username
        let idmascota = mascota.objectId
        var condicion = "idMascota = '" + idmascota! + "' And usuarioOrigen = '" + currentuser! + "' OR  usuarioDestino = '" + currentuser!
        condicion += "'"
        
        
        
        let predicate = NSPredicate(format:condicion)
        let query = PFQuery(className: "mensaje",predicate: predicate)
        query.orderByAscending("createdAt")
        
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                
                
                
                if let objects = objects {
                    
                    for object in objects {
                        
                        
                        if(object["usuarioOrigen"] as! String == currentuser)
                        {
                            self.mensajesTextView.text = self.mensajesTextView.text + "Tú:\n" + (object["mensaje"] as! String) + "\n\n"
                        }
                        else
                        {
                            self.mensajesTextView.text = self.mensajesTextView.text + (object["usuarioOrigen"]! as! String) + ":\n" + (object["mensaje"] as! String) + "\n\n"

                        }
                        
                    }
                }
                
                
            }else{
                print("Error: \(error) \(error!.userInfo)")
            }
        }
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnEnviar(sender: AnyObject)
    {
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
