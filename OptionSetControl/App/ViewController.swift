//
//  ViewController.swift
//  OptionSetControl
//
//  Created by Rudolf Farkas on 15.06.20.
//  Copyright © 2020 Rudolf Farkas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var optionsPicker: ShareOptionsPicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        optionsPicker.setupButtons(buttonsPerRow: 2)
    }

    @IBAction func optionsDidChange(_ sender: ShareOptionsPicker) {
        // Helpers
        let userDefaults = UserDefaults.standard

        // Store Value
        let optionsRawValue = sender.options.rawValue
        userDefaults.set(optionsRawValue, forKey: UserDefaults.Keys.options)
    }
}

extension UserDefaults {
    enum Keys {
        static let options = "options"
    }
}
