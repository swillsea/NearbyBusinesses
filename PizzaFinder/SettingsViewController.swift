//
//  SettingsViewController.swift
//  PizzaFinder
//
//  Created by Sam on 4/6/16.
//  Copyright © 2016 Sam Willsea. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var distanceLabel: UILabel!
    var searchRange = Float()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchRange = distanceSlider.value * 69
        distanceLabel.text = String(format: "%1.0f miles from current location", searchRange)
    }
    
    @IBAction func onDistanceSliderChanged(sender: UISlider) {
        
        self.searchRange = distanceSlider.value * 69
        distanceLabel.text = String(format: "%1.0f miles from current location", searchRange)
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
