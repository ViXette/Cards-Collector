//
//  ViewController.swift
//  Cards Collector
//
//  Created by VX on 30/08/16.
//  Copyright © 2016 VXette. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var cards_TableView: UITableView!
    
    var cards :[Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cards_TableView.dataSource = self
        cards_TableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            cards = try context.fetch(Card.fetchRequest())
            cards_TableView.reloadData()
        } catch {
            
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let card = cards[indexPath.row]
        cell.textLabel?.text = card.title
        cell.imageView?.image = UIImage(data: card.image as! Data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = cards[indexPath.row]
        performSegue(withIdentifier: "cardSegue", sender: card)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let nextVC = segue.destination as! CardViewController
        nextVC.card = sender as? Card
        
    }

}

