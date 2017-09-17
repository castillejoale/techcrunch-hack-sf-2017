//
//  CustomAnnotationView.swift
//  techcrunch-hack-sf-2017
//
//  Created by Alejandro Castillejo on 9/16/17.
//  Copyright © 2017 propelland. All rights reserved.
//

import Foundation
import Mapbox

// MGLAnnotationView subclass
class CustomAnnotationView: MGLAnnotationView {
    
    @IBOutlet weak var pinWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var moreContainerWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var moreContainer: UIView!
    
    @IBOutlet weak var emojiContainer: UIView!
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var pinView: UIView!
    
    @IBOutlet weak var emojiLabel: UILabel!
    
    @IBOutlet weak var moreLabel: UILabel!
    
    @IBOutlet weak var imageBackgroundView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        commonInit()
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.commonInit()
        
    }
    
    override init(reuseIdentifier: String?) {
        
        super.init(reuseIdentifier: reuseIdentifier)
 
    }
    
    private func commonInit() {
        
        Bundle.main.loadNibNamed("CustomAnnotationView", owner: self, options: nil)
        
        addSubview(self.contentView)
        
        let bounds = self.bounds
        
        self.contentView.frame = bounds
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Force the annotation view to maintain a constant size when the map is tilted.
        scalesWithViewingDistance = false
        
        // Use CALayer’s corner radius to turn this view into a circle.
//        self.pinView.layer.cornerRadius = self.pinView.frame.height / 2
//        self.pinView.layer.borderWidth = 2
//        self.pinView.layer.borderColor = UIColor.white.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
//        // Animate the border width in/out, creating an iris effect.
//        let animation = CABasicAnimation(keyPath: "borderWidth")
//        animation.duration = 0.1
//        layer.borderWidth = selected ? frame.width / 4 : 2
//        layer.add(animation, forKey: "borderWidth")
    }
    
    func updateView(request:Request) {
        
        print(request)
        
        self.emojiLabel.text = request.needs[0].description

        if request.needs.count < 2 {
            
            self.pinWidthConstraint.constant = 42
            self.moreContainerWidthConstraint.constant = 2
            self.moreLabel.isHidden = true
            self.imageBackgroundView.image = UIImage(named: "smallBlue")
            
        } else {
            
            self.moreLabel.text = "+" + String(request.needs.count - 1)
            
            self.imageBackgroundView.image = UIImage(named: "bigBlue")
            
        }

    }
    
    
}
