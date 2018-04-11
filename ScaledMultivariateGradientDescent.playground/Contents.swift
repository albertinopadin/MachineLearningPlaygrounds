//: Playground - noun: a place where people can play

//
//  ScaledMultivariateGradientDescent
//
//  Created by Albertino Padin on 4/9/18.
//  Copyright © 2018 Albertino Padin. All rights reserved.
//

import Foundation

// Scaled Multivariate Gradient Descent
// This is the linear relationship y = 4x + 2.
// This algorithm scales the features based on the feature range and attempts
// gradient descent to find the correct thetas, starting at a specified values.

//let xValues: [Double] = [0, 1, 2, 3]
//let yValues: [Double] = [2, 6, 10, 14]
//
//let zValsStart: [Double] = [0.0, 0.0]


// This is the linear relationship y = 10x + 40.
let xValues: [Double] = [0, 1, 2, 3]
let yValues: [Double] = [40, 50, 60, 70]

let zValsStart: [Double] = [100.0, 100.0]

let stepSize: Double = 0.8
let maxIterations = 1000

let zVals = scaledMultivariateGradientDescent(initialZValues: zValsStart,
                                             xValues: xValues,
                                             yValues: yValues,
                                             maxIterations: maxIterations,
                                             stepSize: stepSize)


print("Lowest error Zeta values found: \(zVals)")

print("Equation with found z values: y = \(zVals[1])x + \(zVals[0])")
