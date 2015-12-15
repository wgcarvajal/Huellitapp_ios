//
//  AgregarmascotaViewController.swift
//  Huellitapp
//
//  Created by Aplimovil on 14/12/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import UIKit
import Parse
import Bolts

class AgregarmascotaViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var fotoMascota: UIImageView!
    @IBOutlet var txtnombre: UITextField!
    @IBOutlet var txtDescripcion: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnSeleccionar(sender: AnyObject)
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func btnAgregar(sender: AnyObject)
    {
        
        let nombre = txtnombre.text
        let descripcion = txtDescripcion.text
        
        
        
        if (nombre!.isEmpty || descripcion!.isEmpty || fotoMascota.image == nil)
        {
            
            
            var myAlert = UIAlertController(title: "Campos obligatorios", message: "Todos los campos son obligatorios", preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil)
            
            myAlert.addAction(okAction)
            
            self.presentViewController(myAlert, animated: true, completion: nil)
            
            return
            
        }
        
        
        
        var currentuser = PFUser.currentUser()
        
        var mascota = PFObject(className:"mascota")
        mascota["masnombre"] = nombre
        mascota["masdescripcion"] = descripcion
        mascota["username"] = currentuser?.username
        mascota["tiponombre"] = "Adultos"
        mascota["masedad"] = "4"
        mascota.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success)
            {
                let fotoMascotaData = UIImageJPEGRepresentation(self.fotoMascota.image!, 1)
                if(fotoMascotaData != nil)
                {
                    let fotico = PFFile(data:fotoMascotaData!)
                    var photo = PFObject(className:"fotomascota")
                    photo["mascota"] = mascota.objectId
                    photo["foto"] = fotico
                    photo.saveInBackgroundWithBlock({ (successfoto:Bool, errorfoto:NSError?) -> Void in
                        if(successfoto)
                        {
                            
                        }
                        else
                        {
                            var myAlert = UIAlertController(title: "error", message: errorfoto?.description, preferredStyle: UIAlertControllerStyle.Alert)
                            
                            let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.Default, handler: nil)
                            
                            myAlert.addAction(okAction)
                            
                            self.presentViewController(myAlert, animated: true, completion: nil)
                            
                            return
                        }
                    })
                }
                
            } else {
                // There was a problem, check error.description
            }
        }
        
        
        
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            fotoMascota.contentMode = .ScaleAspectFit
            fotoMascota.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
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
