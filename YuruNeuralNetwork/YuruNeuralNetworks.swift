//
//  YuruNeuralNetworks.swift
//  YuruNeuralNetwork
//
//  Created by クワシマ・ユウキ on 2021/01/24.
//
import Foundation

class YuruNeuralNetworks {
    
//    public class NN_Kaiki {
//        public init() {
//
//            let inputDataX = YuruCompute.createFloatData(-1, 1, 0.2)
//            let inputDataY = YuruCompute.createFloatData(-1, 1, 0.2)
//
//            let w_im = YuruMatrix(array: [4, 4, 4, 4], tate: 2, yoko: 2)
//            let w_mo = YuruMatrix(array: [1, -1], tate: 2, yoko: 1)
//            let b_im = YuruMatrix(array: [3, -3], tate: 1, yoko: 2)
//            let b_mo = YuruMatrix(array: [0.1], tate: 1, yoko: 1)
//
//            var zeros = YuruMatrix.createZeros(row: 10, col: 10).getFloatArray()
//
//            for i in 0..<10{
//                for j in 0..<10{
//                    let input = YuruMatrix(array: [inputDataX[i], inputDataY[j]], tate: 1, yoko: 2)
//                    let middle = middleLayer(input: input, weight: w_im, bias: b_im)
//                    let output = outputLayer(input: middle, weight: w_mo, bias: b_mo)
//
//                    zeros[i * 10 + j] = output.getFloatArray()[0]
//                }
//            }
//        }
//        public func middleLayer(input: YuruMatrix, weight: YuruMatrix, bias: YuruMatrix) -> YuruMatrix {
//            var product = YuruMatrix.product(ymatrix1: input, ymatrix2: weight)
//            let sum = product.add(ymatrix: bias)
//            return YuruCompute.sigmoid(x: sum)
//        }
//        public func outputLayer(input: YuruMatrix, weight: YuruMatrix, bias: YuruMatrix) -> YuruMatrix {
//            return input.product(ymatrix: weight).add(ymatrix: bias)
//        }
//    }
//
//    public class NN_Bunrui {
//        public init() {
//            let x = YuruCompute.createFloatData(-1, 1, 0.1)
//            let y = YuruCompute.createFloatData(-1, 1, 0.1)
//
//            let w_im = YuruMatrix(array: [1, 2, 2, 3], tate: 2, yoko: 2)
//            let w_mo = YuruMatrix(array: [-1, 1, 1, -1], tate: 2, yoko: 2)
//
//            let b_im = YuruMatrix(array: [0.3, -0.3], tate: 1, yoko: 2)
//            let b_mo = YuruMatrix(array: [0.4, 0.1], tate: 1, yoko: 2)
//
//            var results = YuruMatrix(array: [Float](repeating: 0, count: 20*20), tate: 20, yoko: 20).getFloatArray2Dim()
//
//            for i in 0..<20{
//                for j in 0..<20{
//                    let input = YuruMatrix(array: [x[i], y[j]], tate: 1, yoko: 2)
//                    let middle = middleLayer(input: input, weight: w_im, bias: b_im)
//                    let out = outputLayer(input: middle, weight: w_mo, bias: b_mo)
//
//                    let outArray = out.getFloatArray()
//
//                    if outArray[0] > outArray[1] {
//                        results[i][j] = 1
//                    } else {
//                        results[i][j] = 0
//                    }
//                }
//            }
//            for r in results{
//                print(r)
//            }
//        }
//
//        public func middleLayer(input: YuruMatrix, weight: YuruMatrix, bias: YuruMatrix) -> YuruMatrix {
//            return YuruCompute.sigmoid(x: input.product(ymatrix: weight).add(ymatrix: bias))
//        }
//
//        public func outputLayer(input: YuruMatrix, weight: YuruMatrix, bias: YuruMatrix) -> YuruMatrix {
//            let u = input.product(ymatrix: weight).add(ymatrix: bias)
//            return YuruCompute.softmax(x: u)
//        }
//    }
//
//    public class NN_Backprop_Kaiki {
//
//        public init() {
//            let middlelayer = MiddleLayer(upperLayerCount: 1, thisLayerCount: 3)
//            let outputLayer = OutputLayer(upperLayerCount: 3, thisLayerCount: 1)
//
//            var inputData = YuruCompute.createFloatData(0, Float.pi * 2, 0.1)
//            var correctData: [Float] = []
//            for i in inputData{
//                correctData.append(sin(i))
//            }
//            for i in 0..<inputData.count{
//                inputData[i] = (inputData[i] - Float.pi) / Float.pi
//            }
//            let dataNum = correctData.count
//
//            let learningRate: Float = 0.01
//
//
//            for i in 0..<2001 {
//                var indexs: [Int] = []
//                for c in 0..<dataNum{
//                    indexs.append(c)
//                }
//                indexs.shuffle()
//
//                var totalError = 0
//                var plotX: [Float] = []
//                var plotY: [Float] = []
//
//                for idx in 0..<indexs.count{
//                    let input = inputData[indexs[idx]]
//                    let correct = correctData[indexs[idx]]
//
//                    middlelayer.forward(input: YuruMatrix(array: [input], tate: 1, yoko: 1))
//                    outputLayer.forward(input: middlelayer.output)
//
//                    outputLayer.backward(correctData: YuruMatrix(array: [correct], tate: 1, yoko: 1))
//                    middlelayer.backward(grad_y: outputLayer.grad_x)
//
//                    middlelayer.update(learningRate: learningRate)
//                    outputLayer.update(learningRate: learningRate)
//
//                    if i % 100 == 0{
//                        let tempY = outputLayer.output
//
////                        totalError += Float(1) / Float(2) * YuruMatrix.sumOfAllElements((tempY!.subtract(ymatrix: YuruMatrix(array: [Float](repeating: correct, count: tempY!.getRowCount() * tempY!.getColCount()), tate: tempY!.getColCount(), yoko: 1)))!)
//                    }
//                }
//            }
//        }
//
//        public class OutputLayer {
//
//            var weight: YuruMatrix
//            var bias: YuruMatrix
//
//            let wb_width: Float = 0.01
//
//            var input: YuruMatrix!
//            var output: YuruMatrix!
//
//            var grad_w: YuruMatrix!
//            var grad_b: YuruMatrix!
//            var grad_x: YuruMatrix!
//
//            public init(upperLayerCount: Int, thisLayerCount: Int){
//                let distArray = YuruCompute.get_distribution(count: upperLayerCount * thisLayerCount)
//                weight = YuruMatrix(array: distArray, tate: upperLayerCount, yoko: thisLayerCount).multiplyScalar(scalar: wb_width)
//                let biasDistArray = YuruCompute.get_distribution(count: thisLayerCount)
//                bias = YuruMatrix(array: biasDistArray, tate: 1, yoko: thisLayerCount)
//            }
//
//            public func forward(input: YuruMatrix) {
//                self.input = input
//                let u = self.input.product(ymatrix: self.weight).add(ymatrix: self.bias)
//                self.output = u
//            }
//
//            public func backward(correctData: YuruMatrix) {
//                let delta = self.output.subtract(ymatrix: correctData)
//                self.grad_w = self.input.transpose().product(ymatrix: delta)
//                self.grad_b = delta.sumOfAllElementsInRow()
//                self.grad_x = delta.product(ymatrix: self.weight.transpose())
//            }
//
//            public func update(learningRate: Float) {
//                self.weight.subtract(ymatrix: self.grad_w.multiplyScalar(scalar: learningRate))
//                self.bias.subtract(ymatrix: self.grad_b.multiplyScalar(scalar: learningRate))
//            }
//        }
//
//        public class MiddleLayer {
//
//            var weight: YuruMatrix
//            var bias: YuruMatrix
//
//            let wb_width: Float = 0.01
//
//            var input: YuruMatrix!
//            var output: YuruMatrix!
//
//            var grad_w: YuruMatrix!
//            var grad_b: YuruMatrix!
//            var grad_x: YuruMatrix!
//
//            public init(upperLayerCount: Int, thisLayerCount: Int) {
//                let distArray = YuruCompute.get_distribution(count: upperLayerCount * thisLayerCount)
//                weight = YuruMatrix(array: distArray, tate: upperLayerCount, yoko: thisLayerCount).multiplyScalar(scalar: wb_width)
//                let biasDistArray = YuruCompute.get_distribution(count: thisLayerCount)
//                bias = YuruMatrix(array: biasDistArray, tate: 1, yoko: thisLayerCount)
//            }
//
//            public func forward(input: YuruMatrix){
//                self.input = YuruMatrix.copy(ymatrix: input)
//                let u = self.input.product(ymatrix: self.weight).add(ymatrix: self.bias)
//                self.output = YuruCompute.sigmoid(x: u)
//            }
//
//            public func backward(grad_y: YuruMatrix){
//                let delta = grad_y.elementwiseProduct(ymatrix: YuruMatrix.createOnes(row: self.output.getRowCount(), col: self.output.getColCount()).subtract(ymatrix: self.output)).self.elementwiseProduct(ymatrix: self.output)
//
//                self.grad_w = self.input.transpose().product(ymatrix: delta)
//                self.grad_b = delta.sumOfAllElementsInRow()
//                self.grad_x = delta.product(ymatrix: self.weight.transpose())
//            }
//
//            public func update(learningRate: Float){
//                self.weight.subtract(ymatrix: self.grad_w.multiplyScalar(scalar: learningRate))
//                self.bias.subtract(ymatrix: self.grad_b.multiplyScalar(scalar: learningRate))
//            }
//        }
//
//
//    }
    
    public class NN_Backprop_Kaiki_Test {
        
        public init() {
            let inputData = YuruCompute.createFloatData(0, Float.pi * 2, 0.1)
            let correctData = inputData.map {
                sin($0)
            }
            let normalizedInputData = inputData.map {
                ($0 - Float.pi) / Float.pi
            }
            
            let learningRate: Float = 0.1
            let epoch = 2000
            
            let midLayer = MiddleLayer(upperLayerCount: 1, thisLayerCount: 3)
            let outLayer = OutputLayer(upperLayerCount: 3, thisLayerCount: 1)
            for k in 0..<epoch {
                var totalError: Float = 0
                var plotX: [Float] = []
                var plotY: [Float] = []
                
                for i in 0..<correctData.count{
                    let x = normalizedInputData[i]
                    let c = correctData[i]
                    
                    midLayer.forward(input: YuruMatrix(array: [x], tate: 1, yoko: 1 ))
                    outLayer.forward(input: midLayer.output)
                    
                    outLayer.back(correct: YuruMatrix(array: [c], tate: 1, yoko: 1))
                    midLayer.back(gradOutput: outLayer.gradInput)
                    
                    midLayer.update()
                    outLayer.update()
                    
                    let res = outLayer.output.getFloatArray()[0]
                    totalError += 1.0/2.0 * sqrt(res - correctData[i])
//
//                    if k % 200 == 0{
//                        plotX.append(x)
//                        plotY.append(res)
//                        print(plotX)
//                        print(plotY)
//                        print(totalError)
//                        print(k)
//                    }
                    print(k)
                    
                    
                }
            }
            
            
            
        }
        
        class OutputLayer{
            
            var weight: YuruMatrix
            var bias: YuruMatrix
            var input: YuruMatrix!
            
            var gradW: YuruMatrix!
            var gradB: YuruMatrix!
            var gradInput: YuruMatrix!
            
            var output: YuruMatrix!
            
            public init(upperLayerCount: Int, thisLayerCount: Int){
                weight = YuruMatrix(array: [Float](repeating: 0.1, count: upperLayerCount * thisLayerCount), tate: upperLayerCount, yoko: thisLayerCount)
                bias = YuruMatrix(array: [Float](repeating: 0.1, count: thisLayerCount), tate: 1, yoko: thisLayerCount)
            }
            
            public func forward(input: YuruMatrix){
                self.input = YuruMatrix.copy(ymatrix: input)
                var prod = YuruMatrix.product(ymatrix1: input, ymatrix2: weight)
                self.output = prod.add(ymatrix: bias)
            }
            
            public func back(correct: YuruMatrix){
                let delta = YuruMatrix.difference(ymatrix1: self.output, ymatrix2: correct)
                var temp = YuruMatrix.transpose(ymatrix: input)
                self.gradW = temp.product(ymatrix: delta)
                self.gradB = YuruMatrix.copy(ymatrix: delta)
                self.gradInput = YuruMatrix.product(ymatrix1: delta, ymatrix2: YuruMatrix.transpose(ymatrix: self.weight))
            }
            
            public func update() {
                self.weight.subtract(ymatrix: YuruMatrix.multiplyScalar(ymatrix: self.gradW, scalar: 0.1))
                self.bias.subtract(ymatrix: YuruMatrix.multiplyScalar(ymatrix: self.gradB, scalar: 0.1))
            }
        }
        
        class MiddleLayer {
            var weight: YuruMatrix
            var bias: YuruMatrix
            var input: YuruMatrix!
            
            var gradW: YuruMatrix!
            var gradB: YuruMatrix!
            var gradInput: YuruMatrix!
            
            var output: YuruMatrix!
            
            public init(upperLayerCount: Int, thisLayerCount: Int){
                weight = YuruMatrix(array: [Float](repeating: 0.1, count: upperLayerCount * thisLayerCount), tate: upperLayerCount, yoko: thisLayerCount)
                bias = YuruMatrix(array: [Float](repeating: 0.1, count: thisLayerCount), tate: 1, yoko: thisLayerCount)
            }
            
            public func forward(input: YuruMatrix){
                self.input = YuruMatrix.copy(ymatrix: input)
                
                var prod = YuruMatrix.product(ymatrix1: input, ymatrix2: weight)
                let u = prod.add(ymatrix: bias)
                self.output = YuruCompute.sigmoid(x: u)
            }
            
            public func back(gradOutput: YuruMatrix){
                var temptemp = YuruMatrix.createOnes(row: self.output.getRowCount(), col: self.output.getColCount())
                var temp = temptemp.subtract(ymatrix: self.output)
                var te = YuruMatrix.elementwiseProduct(ymatrix1: gradOutput, ymatrix2: temp)
                let delta = te.elementwiseProduct(ymatrix: self.output)
                
                var trs = YuruMatrix.transpose(ymatrix: input)
                self.gradW = trs.product(ymatrix: delta)
                self.gradB = YuruMatrix.copy(ymatrix: delta)
                self.gradInput = YuruMatrix.product(ymatrix1: delta, ymatrix2: YuruMatrix.transpose(ymatrix: self.weight))
                
                
            }
            
            public func update() {
                self.weight.subtract(ymatrix: YuruMatrix.multiplyScalar(ymatrix: self.gradW, scalar: 0.1))
                self.bias.subtract(ymatrix: YuruMatrix.multiplyScalar(ymatrix: self.gradB, scalar: 0.1))
            }
        }
    }
    
}
