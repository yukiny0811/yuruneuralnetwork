//
//  YuruGPU.swift
//  YuruNeuralNetwork
//
//  Created by クワシマ・ユウキ on 2021/01/24.
//

import Metal

class YuruGPU {
    
    public static let shared = YuruGPU()
    
    private let device: MTLDevice!
    private let commandQueue: MTLCommandQueue!
    private let library: MTLLibrary!
    
    private init() {
        self.device = MTLCreateSystemDefaultDevice()
        let frameworkBundle = Bundle(for: YuruGPU.self)
        self.library = try! self.device.makeDefaultLibrary(bundle: frameworkBundle)
        self.commandQueue = self.device.makeCommandQueue()!
    }
    
    private func Run_Default(functionName: String, inputDatas: [[Float]], outputData: inout [Float], tate: Int, yoko: Int) -> YuruMatrix {
        
        //metal setup
        let commandBuffer: MTLCommandBuffer! = self.commandQueue.makeCommandBuffer()
        let computeCommandEncoder: MTLComputeCommandEncoder! = commandBuffer.makeComputeCommandEncoder()
        let function: MTLFunction! = self.library.makeFunction(name: functionName)
        let computePipelineState: MTLComputePipelineState! = try! self.device.makeComputePipelineState(function: function)
        computeCommandEncoder.setComputePipelineState(computePipelineState)
        
        //create buffer
        var inputBuffers: [MTLBuffer] = []
        for i in 0..<inputDatas.count {
            inputBuffers.append(self.device.makeBuffer(bytes: inputDatas[i], length: MemoryLayout<Float>.size * inputDatas[i].count, options: [])!)
        }
        let outputBuffer = self.device.makeBuffer(bytes: outputData, length: MemoryLayout<Float>.size * outputData.count, options: [])
        
        //set buffer
        for i in 0..<inputBuffers.count {
            computeCommandEncoder.setBuffer(inputBuffers[i], offset: 0, index: i)
        }
        computeCommandEncoder.setBuffer(outputBuffer, offset: 0, index: inputBuffers.count)
        
        //calculate threads
        let width = computePipelineState.threadExecutionWidth
        let threadGroupsPerGrid = MTLSize(width: (outputData.count + width - 1) / width, height: 1, depth: 1)
        let threadsPerThreadGroup = MTLSize(width: width, height: 1, depth: 1)
        computeCommandEncoder.dispatchThreadgroups(threadGroupsPerGrid, threadsPerThreadgroup: threadsPerThreadGroup)
        
        //end command encoding
        computeCommandEncoder.endEncoding()
        
        inputBuffers = []
        
        //commit command buffer
        commandBuffer.commit()
        commandBuffer.waitUntilCompleted()
        
        //get result
        let resultData = Data(bytesNoCopy: outputBuffer!.contents(), count: MemoryLayout<Float>.size * outputData.count, deallocator: .none)
        outputData = resultData.withUnsafeBytes {
            Array(
                UnsafeBufferPointer(
                    start: $0.baseAddress!.assumingMemoryBound(to: Float.self),
                    count: $0.count / MemoryLayout<Float>.size
                )
            )
        }
        return YuruMatrix(array: outputData, tate: tate, yoko: yoko)
    }
    
    public func Run_ExpOfMatrix(ymatrix: YuruMatrix) -> YuruMatrix {
        var outputArray: [Float] = [Float](repeating: 0, count: ymatrix.getRowCount() * ymatrix.getColCount())
        return YuruGPU.shared.Run_Default(functionName: "exp_of_matrix", inputDatas: [ymatrix.getFloatArray()], outputData: &outputArray, tate: ymatrix.getRowCount(), yoko: ymatrix.getColCount())
    }
    
    public func Run_LogOfMatrix(ymatrix: YuruMatrix) -> YuruMatrix {
        var outputArray: [Float] = [Float](repeating: 0, count: ymatrix.getRowCount() * ymatrix.getColCount())
        return YuruGPU.shared.Run_Default(functionName: "log_of_matrix", inputDatas: [ymatrix.getFloatArray()], outputData: &outputArray, tate: ymatrix.getRowCount(), yoko: ymatrix.getColCount())
    }
    
    public func Run_ScalarDividedByMatrix(ymatrix: YuruMatrix, scalar: Float) -> YuruMatrix {
        var outputArray: [Float] = [Float](repeating: 0, count: ymatrix.getRowCount() * ymatrix.getColCount())
        return YuruGPU.shared.Run_Default(functionName: "scalar_divided_by_matrix", inputDatas: [ymatrix.getFloatArray(), [scalar]], outputData: &outputArray, tate: ymatrix.getRowCount(), yoko: ymatrix.getColCount())
    }
    
    public func Run_SqrtOfMatrix(ymatrix: YuruMatrix) -> YuruMatrix {
        var outputArray: [Float] = [Float](repeating: 0, count: ymatrix.getRowCount() * ymatrix.getColCount())
        return YuruGPU.shared.Run_Default(functionName: "sqrt_of_matrix", inputDatas: [ymatrix.getFloatArray()], outputData: &outputArray, tate: ymatrix.getRowCount(), yoko: ymatrix.getColCount())
    }
}
