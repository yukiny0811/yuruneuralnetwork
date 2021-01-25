//
//  YuruCompute.metal
//  YuruNeuralNetwork
//
//  Created by クワシマ・ユウキ on 2021/01/24.
//

#include <metal_stdlib>
using namespace metal;

kernel void exp_of_matrix (const device float* inputData [[ buffer(0) ]],
                        device float* outputData [[ buffer(1) ]],
                        uint thread_position_in_grid [[thread_position_in_grid]]) {
    outputData[thread_position_in_grid] =  exp(inputData[thread_position_in_grid]);
}

kernel void log_of_matrix (const device float* inputData [[ buffer(0) ]],
                        device float* outputData [[ buffer(1) ]],
                        uint thread_position_in_grid [[thread_position_in_grid]]) {
    outputData[thread_position_in_grid] =  log(inputData[thread_position_in_grid]);
}

kernel void scalar_divided_by_matrix (const device float* matrix [[ buffer(0) ]],
                                      const device float* scalar [[ buffer(1) ]],
                        device float* outputData [[ buffer(2) ]],
                        uint thread_position_in_grid [[thread_position_in_grid]]) {
    outputData[thread_position_in_grid] = scalar[0] / matrix[thread_position_in_grid];
}

kernel void sqrt_of_matrix (const device float* inputData [[ buffer(0) ]],
                        device float* outputData [[ buffer(1) ]],
                        uint thread_position_in_grid [[thread_position_in_grid]]) {
    outputData[thread_position_in_grid] =  sqrt(inputData[thread_position_in_grid]);
}
