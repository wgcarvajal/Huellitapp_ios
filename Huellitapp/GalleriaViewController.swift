//
//  GalleriaViewController.swift
//  Huellitapp
//
//  Created by Aplimovil on 15/12/15.
//  Copyright © 2015 Aplimovil. All rights reserved.
//

import UIKit
import Parse
import Bolts

var fotosMascotas = [PFObject]()
class GalleriaViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate {

    var mascota:PFObject!
    
    @IBOutlet var collectionGalleria: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
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
        let celda:ItemgalleriaCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("itemGalleria", forIndexPath: indexPath) as! ItemgalleriaCollectionViewCell
        
        //celda.fechaEvento.text = self.data[indexPath.row]
        //celda.nombreEvento.text = self.data[indexPath.row]
        
        

        if let value = fotosMascotas[indexPath.row]["foto"] as? PFFile {
            //let finalImage = eventos[indexPath.row]["foto"] as? PFFile
            value.getDataInBackgroundWithBlock {
                (imageData: NSData?, error: NSError?) -> Void in
                if error == nil {
                    if let imageData = imageData {
                        celda.fotoMascota.image = UIImage(data:imageData)
                    }
                }
            }
        }
        
        
        return celda
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fotosMascotas.count
    }
    
    func cargardata(){
        
        
        let query = PFQuery(className: "fotomascota")
        query.whereKey("mascota", equalTo: mascota.objectId!)
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error: NSError?) -> Void in
            
            if error == nil{
                
                fotosMascotas.removeAll(keepCapacity: true)
                
                if let objects = objects {
                    fotosMascotas = Array(objects.generate())
                }
                
                self.collectionGalleria.reloadData()
            }else{
                print("Error: \(error) \(error!.userInfo)")
            }
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
