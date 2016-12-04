//
//  ViewController.swift
//  KeyInput
//
//  Created by Ryota Hayashi on 2016/11/28.
//  Copyright © 2016年 bitflyer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var field: PINField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func handleFieldEndEditing(field: PINField) {
        print("\(#file).\(#function)")
    }
}

