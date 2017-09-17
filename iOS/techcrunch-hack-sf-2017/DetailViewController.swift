//
//  DetailViewController.swift
//  
//
//  Created by Alejandro Castillejo on 9/16/17.
//
//

import UIKit

class DetailViewController: UIViewController {
    
    var request:Request!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        print(request.id)
    }
    @IBAction func backWasPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }

}
