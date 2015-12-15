//
//  MismascotasViewController.swift
//  Huellitapp
//
//  Created by Aplimovil on 14/12/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import UIKit
import Parse
import Bolts

var mismascotas = [PFObject]()

class MismascotasViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate{

    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func salir(sender: AnyObject)
    {
        
        PFUser.logOutInBackground()
        self.performSegueWithIdentifier("cerrarSesion", sender: nil)
        
    }
    
    override func viewDidAppear(animated: Bool)
    {
        cargardata()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let celda:MimascotaCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("celdaMiMascota", forIndexPath: indexPath) as! MimascotaCollectionViewCell
        
        //celda.fechaEvento.text = self.data[indexPath.row]
        //celda.nombreEvento.text = self.data[indexPath.row]
        
        if let nombre = mismascotas[indexPath.row]["masnombre"] as? String{
            celda.lblnombre.text = nombre
        }
        
        if let tipo = mismascotas[indexPath.row]["tiponombre"] as? String{
            
            var edad=" años"
            if(tipo == "Cachorros")
            {
                edad = " meses"
            }
            
            if let edadMascota = mismascotas[indexPath.row]["masedad"] as? String{
                celda.lbledad.text = edadMascota + edad
            }
            
            
        }
        
        if let descripcion = mismascotas[indexPath.row]["masdescripcion"] as? String{
            celda.lblDescripcion.text = descripcion
        }
        
        let query = PFQuery(className:"fotomascota")
        query.whereKey("mascota", equalTo:mismascotas[indexPath.row].objectId!)
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
                                    celda.imageView.image = UIImage(data:imageData)
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
        
        
        
        
        
        
        return celda
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mismascotas.count
    }
    
    func cargardata(){
        
        var currentuser = PFUser.currentUser()?.username
        let query = PFQuery(className: "mascota")
        query.whereKey("username", equalTo: currentuser!)
        
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                
                mismascotas.removeAll(keepCapacity: true)
                
                if let objects = objects {
                    mismascotas = Array(objects.generate())
                }
                
                self.collectionView.reloadData()
            }else{
                print("Error: \(error) \(error!.userInfo)")
            }
        }
    }

    
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "mostrarMiMascota"{
            
            let indexPaths = self.collectionView.indexPathsForSelectedItems()!
            let indexPath = indexPaths[0] as NSIndexPath
            
            let vc = segue.destinationViewController as! MimascotaViewController
            vc.mascota = mismascotas[indexPath.row]
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
