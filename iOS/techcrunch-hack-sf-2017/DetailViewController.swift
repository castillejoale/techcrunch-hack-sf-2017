//
//  DetailViewController.swift
//  
//
//  Created by Alejandro Castillejo on 9/16/17.
//
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var secondNeedView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var personImageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var conditionsLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var needEmoji1Label: UILabel!
    @IBOutlet weak var needDescription1: UILabel!
    
    @IBOutlet weak var needEmoji2: UILabel!
    @IBOutlet weak var needDescription2: UILabel!
    var request:Request!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.descriptionLabel.text = request.personDescription
        self.nameLabel.text = request.name
        self.dateLabel.text = request.dateCreated.getString()
        self.addressLabel.text = "(" + String(request.longitude) + ", " + String(request.latitude) + ")"
        
        self.needDescription1.text = request.needs[0].longDescription
        self.needEmoji1Label.text = request.needs[0].description
        
        if self.request.needs.count == 2 {
            
            self.needDescription2.text = request.needs[1].longDescription
            self.needEmoji2.text = request.needs[1].description
            self.secondNeedView.isHidden = false
            
        }
    }
    
    @IBAction func backWasPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func acceptWasPressed(_ sender: Any) {
        
        RequestsController.sharedInstance.ongoing = true
        
        RequestsController.sharedInstance.updateRequest(request: nil)
        
        self.acceptButton.backgroundColor = UIColor.completeGreen
        self.acceptButton.setTitle("Assistance Completed", for: .normal)
        
    }
}
