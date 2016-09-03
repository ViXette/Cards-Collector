//
//  CardViewController.swift
//  Cards Collector
//
//  Created by VX on 30/08/16.
//  Copyright © 2016 VXette. All rights reserved.
//

import UIKit

class CardViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var card_ImageView: UIImageView!
    @IBOutlet weak var title_TextField: UITextField!
    @IBOutlet weak var add_update_Button: UIButton!
    @IBOutlet weak var delete_Button: UIButton!
    
    var imagePicker = UIImagePickerController()
    var card : Card? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if card != nil {
            card_ImageView.image = UIImage(data: card!.image as! Data)
            title_TextField.text = card!.title
            
            add_update_Button.setTitle("Update", for: .normal)
            delete_Button.isHidden = false
        }
    }
    
    @IBAction func photosTapped(_ sender: AnyObject) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info[UIImagePickerControllerOriginalImage])
        card_ImageView.image = (info[UIImagePickerControllerOriginalImage] as! UIImage)
        imagePicker.dismiss(animated: true, completion: nil)
      }

    @IBAction func cameraTapped(_ sender: AnyObject) {
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: AnyObject) {
        if card == nil {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            card = Card(context: context)
        }
        
        card!.title = title_TextField.text
        card!.image = NSData(data: UIImagePNGRepresentation(card_ImageView.image!)!)

        saveCoreDataAndBack()
    }

    @IBAction func deleteTapped(_ sender: AnyObject) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(card!)
        
        saveCoreDataAndBack()
    }
    
    internal func saveCoreDataAndBack() {
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    
}
