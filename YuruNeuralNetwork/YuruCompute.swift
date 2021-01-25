//
//  YuruCompute.swift
//  YuruNeuralNetwork
//
//  Created by クワシマ・ユウキ on 2021/01/24.
//
import Foundation

class YuruCompute {
    public static func createFloatData(_ startFloat: Float, _ endFloat: Float, _ interval: Float) -> [Float] {
        var resultData: [Float] = []
        for i in stride(from: startFloat, to: endFloat, by: interval){
            resultData.append(i)
        }
        return resultData
    }
    
    public static func sigmoid(x: YuruMatrix) -> YuruMatrix{
        var exp_finished_matrix = YuruGPU.shared.Run_ExpOfMatrix(ymatrix: YuruMatrix.multiplyScalar(ymatrix: x, scalar: -1))
        let bunbo = exp_finished_matrix.add(ymatrix: YuruMatrix.createOnes(row: exp_finished_matrix.getRowCount(), col: exp_finished_matrix.getColCount()))
        let result = YuruGPU.shared.Run_ScalarDividedByMatrix(ymatrix: bunbo, scalar: 1)
        return result
    }
    
    public static func softmax(x: YuruMatrix) -> YuruMatrix {
        let exp_finished_matrix = YuruGPU.shared.Run_ExpOfMatrix(ymatrix: x)
        let bunbo = Float(1) / exp_finished_matrix.sumOfAllElements()
        return YuruMatrix.multiplyScalar(ymatrix: exp_finished_matrix, scalar: bunbo)
    }
    
    public static func normal_distribution(x: Float) -> Float{
        let a = Float(1) / sqrt(Float(2) * Float(Double.pi))
        let b = pow(x, 2) / Float(2)
        let c = exp(-b)
        let result = a * c
        return result
    }
    
    public static func get_distribution(count: Int) -> [Float] {
        let lower: Float = -3
        let upper: Float = 3
        var result: [Float] = []
        for i in 0..<count{
            let temp = lower + (upper - lower) / Float(count) * Float(i)
            result.append(normal_distribution(x: temp))
        }
        return result
    }
}
