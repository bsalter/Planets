//
//  ViewController.swift
//  Planets
//
//  Created by Benjamin Salter on 8/23/20.
//  Copyright © 2020 Benjamin Salter. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true
    }

    override func viewDidAppear(_ animated: Bool) {
        let earth = makePlanet(geometry: SCNSphere(radius: 0.2), diffuse: UIImage(named: "Earth diffuse")!, specular: UIImage(named: "Earth specular"), emission: UIImage(named: "Earth emission"), normal: UIImage(named: "Earth normal"), position: SCNVector3(1.7, 0, 0))
        earth.runAction(makeRotation(time: 20))
        let earthParent = SCNNode()
        earthParent.position = SCNVector3(0, 0, -1)
        earthParent.runAction(makeRotation(time: 14))
        
        let luna = makePlanet(geometry: SCNSphere(radius: 0.05), diffuse: UIImage(named: "Luna diffuse")!, position: SCNVector3(-0.3, 0, 0))
        luna.runAction(makeRotation(time: 10))
        let lunaParent = SCNNode()
        lunaParent.position = SCNVector3(1.7, 0, 0)
        lunaParent.runAction(makeRotation(time: 10))
        
        let venus = makePlanet(geometry: SCNSphere( radius: 0.1), diffuse: UIImage(named: "Venus diffuse")!, emission: UIImage(named: "Venus emission"), position: SCNVector3(-0.8, 0, 0))
        venus.runAction(makeRotation(time: 15))
        let venusParent = SCNNode()
        venusParent.position = SCNVector3(0, 0, -1)
        venusParent.runAction(makeRotation(time: 10))
        
        let sun = makePlanet(geometry: SCNSphere(radius: 0.35), diffuse: UIImage(named: "Sun diffuse")!, position: SCNVector3(0, 0, -1))
        sun.runAction(makeRotation(time: 75))
        
        sceneView.scene.rootNode.addChildNode(sun)
        sceneView.scene.rootNode.addChildNode(earthParent)
        sceneView.scene.rootNode.addChildNode(venusParent)
        
        earthParent.addChildNode(lunaParent)
        
        earthParent.addChildNode(earth)
        venusParent.addChildNode(venus)
        lunaParent.addChildNode(luna)
    }
    
    func makeRotation(time rotationDuration: Int) -> SCNAction {
        let action = SCNAction.rotateBy(x: 0, y: 360.degreesToRadians, z: 0, duration: TimeInterval(rotationDuration))
        return SCNAction.repeatForever(action)
    }
    
    func makePlanet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage? = nil, emission: UIImage? = nil, normal: UIImage? = nil, position: SCNVector3) -> SCNNode {
        let planet = SCNNode()
        planet.geometry = geometry
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }
}

extension Int {
    var degreesToRadians: CGFloat {
        return CGFloat(Double(self) * .pi/180)
    }
}
