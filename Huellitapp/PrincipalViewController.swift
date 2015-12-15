//
//  PrincipalViewController.swift
//  Huellitapp
//
//  Created by Aplimovil on 14/12/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import UIKit
import Parse
import Bolts


var mascotas = [PFObject]()

class PrincipalViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate {

    
    
    @IBOutlet var collectionViewMascotas: UICollectionView!
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    
    @IBAction func salir(sender: AnyObject)
    {
        PFUser.logOutInBackground()
        self.performSegueWithIdentifier("cerrarSesion", sender: nil)
        
        
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool)
    {
        cargardata()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let celda:CollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("celda", forIndexPath: indexPath) as! CollectionViewCell
        
        //celda.fechaEvento.text = self.data[indexPath.row]
        //celda.nombreEvento.text = self.data[indexPath.row]
        
        if let nombre = mascotas[indexPath.row]["masnombre"] as? String{
            celda.titleLabel.text = nombre
        }
        
        if let tipo = mascotas[indexPath.row]["tiponombre"] as? String{
           
            var edad=" años"
            if(tipo == "Cachorros")
            {
                edad = " meses"
            }
            
            if let edadMascota = mascotas[indexPath.row]["masedad"] as? String{
                celda.labelEdad.text = edadMascota + edad
            }
            
            
        }
        
        if let descripcion = mascotas[indexPath.row]["masdescripcion"] as? String{
            celda.descripcionLabel.text = descripcion
        }
        
        let query = PFQuery(className:"fotomascota")
        query.whereKey("mascota", equalTo:mascotas[indexPath.row].objectId!)
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
        return mascotas.count
    }
    
    func cargardata(){
        
        var currentuser = PFUser.currentUser()
        let query = PFQuery(className: "mascota")
        query.whereKey("username", notEqualTo: currentuser!.username!)
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                
                mascotas.removeAll(keepCapacity: true)
                
                if let objects = objects {
                    mascotas = Array(objects.generate())
                }
                
                self.collectionViewMascotas.reloadData()
            }else{
                print("Error: \(error) \(error!.userInfo)")
            }
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "mostrarMascota"{
            
            let indexPaths = self.collectionViewMascotas.indexPathsForSelectedItems()!
            let indexPath = indexPaths[0] as NSIndexPath
            
            let vc = segue.destinationViewController as! MascotaViewController
            vc.mascota = mascotas[indexPath.row]
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
