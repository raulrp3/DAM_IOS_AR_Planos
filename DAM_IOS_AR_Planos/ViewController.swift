//
//  ViewController.swift
//  DAM_IOS_AR_Planos
//
//  Created by raul.ramirez on 17/02/2020.
//  Copyright © 2020 Raul Ramirez. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var mSceneview: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.mSceneview.debugOptions = [.showWorldOrigin, .showFeaturePoints]
        self.mSceneview.session.run(configuration)
    }


}

