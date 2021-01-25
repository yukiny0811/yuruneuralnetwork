//
//  YuruMatrix.swift
//  YuruNeuralNetwork
//
//  Created by クワシマ・ユウキ on 2021/01/24.
//

import Metal
import Accelerate

struct YuruMatrix {
    
    public var matrix: la_object_t
    
    public init(array: [Float], tate rows: Int, yoko cols: Int) {
        self.matrix = la_matrix_from_float_buffer(array, la_count_t(rows), la_count_t(cols), la_count_t(cols), la_hint_t(LA_NO_HINT), la_attribute_t(LA_DEFAULT_ATTRIBUTES))
    }
    
    public init(matrix: la_object_t) {
        self.matrix = matrix
    }
    
    public func getRowCount() -> Int {
        return Int(la_matrix_rows(self.matrix))
    }
    
    public func getColCount() -> Int {
        return Int(la_matrix_cols(self.matrix))
    }
    
    ///足し算
    public mutating func add(ymatrix: YuruMatrix) -> YuruMatrix {
        self.matrix = la_sum(self.matrix, ymatrix.matrix)
        return self
    }
    
    ///引き算
    public mutating func subtract(ymatrix: YuruMatrix) -> YuruMatrix {
        self.matrix = la_difference(self.matrix, ymatrix.matrix)
        return self
    }
    
    ///スカラー倍
    public mutating func multiplyScalar(scalar: Float) -> YuruMatrix {
        self.matrix = la_scale_with_float(self.matrix, scalar)
        return self
    }
    
    ///各要素の積
    public mutating func elementwiseProduct(ymatrix: YuruMatrix) -> YuruMatrix {
        self.matrix = la_elementwise_product(self.matrix, ymatrix.matrix)
        return self
    }
    
    ///行列積
    public mutating func product(ymatrix: YuruMatrix) -> YuruMatrix {
        self.matrix = la_matrix_product(self.matrix, ymatrix.matrix)
        return self
    }
    
    ///転置行列
    public mutating func transpose() -> YuruMatrix {
        self.matrix = la_transpose(self.matrix)
        return self
    }
    
    public func sumOfAllElements() -> Float {
        return self.getFloatArray().reduce(0, +)
    }
    
    public func getFloatArray() -> [Float] {
        var array: [Float] = [Float](repeating: 0, count: self.getRowCount() * self.getColCount())
        la_matrix_to_float_buffer(&array, la_count_t(self.getColCount()), self.matrix)
        return array
    }
    
    public func getFloatArray2Dim() -> [[Float]] {
        let array = self.getFloatArray()
        var result: [[Float]] = []
        for i in 0..<self.getRowCount() {
            var temp: [Float] = []
            for j in 0..<self.getColCount() {
                temp.append(array[i * self.getRowCount() + j])
            }
            result.append(temp)
        }
        return result
    }
    
    public func sumOfAllElementsInRow() -> YuruMatrix {
        let array = self.getFloatArray2Dim()
        var result: [Float] = []
        for a in 0..<array.count{
            result.append(array[a].reduce(0, +))
        }
        return YuruMatrix(array: result, tate: result.count, yoko: 1)
    }
    
    
    
    
    // static functions
    
    public static func sum(ymatrix1: YuruMatrix, ymatrix2: YuruMatrix) -> YuruMatrix {
        return YuruMatrix(matrix: la_sum(ymatrix1.matrix, ymatrix2.matrix))
    }
    
    public static func difference(ymatrix1: YuruMatrix, ymatrix2: YuruMatrix) -> YuruMatrix {
        return YuruMatrix(matrix: la_difference(ymatrix1.matrix, ymatrix2.matrix))
    }
    
    public static func multiplyScalar(ymatrix: YuruMatrix, scalar: Float) -> YuruMatrix {
        return YuruMatrix(matrix: la_scale_with_float(ymatrix.matrix, scalar))
    }
    
    public static func elementwiseProduct(ymatrix1: YuruMatrix, ymatrix2: YuruMatrix) -> YuruMatrix {
        return YuruMatrix(matrix: la_elementwise_product(ymatrix1.matrix, ymatrix2.matrix))
    }
    
    public static func product(ymatrix1: YuruMatrix, ymatrix2: YuruMatrix) -> YuruMatrix {
        return YuruMatrix(matrix: la_matrix_product(ymatrix1.matrix, ymatrix2.matrix))
    }
    
    public static func transpose(ymatrix: YuruMatrix) -> YuruMatrix {
        return YuruMatrix(matrix: la_transpose(ymatrix.matrix))
    }
    
    // static mathematix functions
    
    /// 行列の各要素をxとして、exp(x)の値を計算する
    public static func exp(_ ymatrix: YuruMatrix) -> YuruMatrix {
        return YuruGPU.shared.Run_ExpOfMatrix(ymatrix: ymatrix)
    }
    
    public static func log(_ ymatrix: YuruMatrix) -> YuruMatrix {
        return YuruGPU.shared.Run_LogOfMatrix(ymatrix: ymatrix)
    }
    
    public static func sqrt(_ ymatrix: YuruMatrix) -> YuruMatrix {
        return YuruGPU.shared.Run_SqrtOfMatrix(ymatrix: ymatrix)
    }
    
    // static matrix creation functions
    
    public static func createZeros(row: Int, col: Int) -> YuruMatrix {
        return YuruMatrix(array: [Float](repeating: 0, count: row * col), tate: row, yoko: col)
    }
    
    public static func createOnes(row: Int, col: Int) -> YuruMatrix {
        return YuruMatrix(array: [Float](repeating: 1, count: row * col), tate: row, yoko: col)
    }
    
    public static func copy(ymatrix: YuruMatrix) -> YuruMatrix {
        return YuruMatrix(matrix: ymatrix.matrix)
    }
    
}
