//
//  ViewController.swift
//  DAM_IOS_AR_Planos
//
//  Created by raul.ramirez on 17/02/2020.
//  Copyright © 2020 Raul Ramirez. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var mSceneview: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.mSceneview.debugOptions = [.showWorldOrigin, .showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        self.mSceneview.session.run(configuration)
        
        self.mSceneview.delegate = self
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        //Detecta el plano horizontal.
        guard let planeAnchor = anchor as? ARPlaneAnchor
            else { return }
        let lava = self.createLava(anchor: planeAnchor)
        node.addChildNode(lava)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        //Actualiza el plano en caso de que ya haya sido detectado.
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
        
        node.enumerateChildNodes{ (node, _) in
            node.removeFromParentNode()
        }
        
        let lava = self.createLava(anchor: planeAnchor)
        node.addChildNode(lava)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        //Eliminar planos.
        guard let _ = anchor as? ARPlaneAnchor else { return }
        
        node.enumerateChildNodes{ (node, _) in
            node.removeFromParentNode()
        }
    }
    
    func createLava(anchor: ARPlaneAnchor) -> SCNNode{
        let node = SCNNode(geometry: SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))) //Como el plano será girado, la altura la mide el eje z.
        node.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "lava")
        node.geometry?.firstMaterial?.isDoubleSided = true
        node.position = SCNVector3(anchor.center.x, anchor.center.y, anchor.center.z)
        node.eulerAngles = SCNVector3(90.degreesToRadians, 0, 0)
        
        return node
    }
}

extension Int{
    var degreesToRadians: Double { return Double(self) * .pi/180 }
}

