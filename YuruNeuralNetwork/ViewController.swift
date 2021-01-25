//
//  ViewController.swift
//  YuruNeuralNetwork
//
//  Created by クワシマ・ユウキ on 2021/01/24.
//

import Cocoa
import MetalKit

class ViewController: NSViewController, MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        <#code#>
    }
    
    func draw(in view: MTKView) {
        <#code#>
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let matrix1 = YuruMatrix(array: [1, 2, 3, 4, 5, 6, 7, 8, 9], tate: 3, yoko: 3)
        let matrix2 = YuruMatrix(array: [7, 8, 9, 10, 11, 12, 13, 14, 15], tate: 3, yoko: 3)
        
        let start = Date().timeIntervalSince1970
        
        //------------------start
        YuruNeuralNetworks.NN_Backprop_Kaiki_Test()
        //------------------end
        
        let end = Date().timeIntervalSince1970
        
        print("Process time took: " + String(format: "%.5f ms", (end - start) * 1000))
    }

    override var representedObject: Any? {
        didSet {
            
        }
    }


}

