//
//  MascotaViewController.swift
//  Huellitapp
//
//  Created by Aplimovil on 14/12/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import UIKit
import Parse
import Bolts

class MascotaViewController: UIViewController {
    
    
    
    @IBOutlet var fotoMascota: UIImageView!
    @IBOutlet var lbldescripcion: UILabel!
    @IBOutlet var lbledad: UILabel!
    
    var mascota:PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbldescripcion.text = mascota["masdescripcion"] as! String
        lbledad.text = mascota["masedad"] as! String
        if(mascota["tiponombre"] as! String == "Cachorros")
        {
            lbledad.text = lbledad.text! + " meses"
        }
        else
        {
            lbledad.text = lbledad.text! + " años"
        }
        
        
        
        
        
        let query = PFQuery(className:"fotomascota")
        query.whereKey("mascota", equalTo:mascota.objectId!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                if let objects = objects {
                    if let value = objects[0]["foto"] as? PFFile {
                        //let finalImage = eventos[indexPath.row]["foto"] as? PFFile
                        value.getDataInBackgroundWithBlock {
                            (imageData: NSData?, error: NSError?) -> Void in
                            if error == nil {
                                if let imageData = imageData {
                                    self.fotoMascota.image = UIImage(data:imageData)
                                }
                            }
                        }
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }

        
        self.title = mascota["masnombre"] as? String
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "mostrarGalleria")
        {
            let vc = segue.destinationViewController as! GalleriaViewController
            vc.mascota = mascota
            
            
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
