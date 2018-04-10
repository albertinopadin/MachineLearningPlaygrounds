//: Playground - noun: a place where people can play

//
//  NaiveMultivariateGradientDescent
//
//  Created by Albertino Padin on 4/8/18.
//  Copyright © 2018 Albertino Padin. All rights reserved.
//

import Foundation

// EXTREMELY Naive Multivariate Gradient Descent
// This is the linear relationship y = 4x + 2.
// This algorithm naively attempts gradient descent to find the correct thetas, starting at a specified values.
// ONLY WORKS WITH LINEAR EQUATIONS

//let xValues: [Double] = [0, 1, 2, 3]
//let yValues: [Double] = [2, 6, 10, 14]
//
//let zValsStart: [Double] = [100.0, -100.0]


// This is the linear relationship y = 10x + 40.
// This algorithm naively attempts gradient descent to find the correct thetas, starting at a specified values.

let xValues: [Double] = [0, 1, 2, 3]
let yValues: [Double] = [40, 50, 60, 70]

let zValsStart: [Double] = [100.0, 100.0]


// WOW!!! The effect of stepSize on this algo is crazy!
// Anything above 0.47 will cause it to diverge spectacularly.
let stepSize: Double = 0.25
let maxIterations = 1000

let zVals = naiveMultivariateGradientDescent(initialZValues: zValsStart,
                                          xValues: xValues,
                                          yValues: yValues,
                                          maxIterations: maxIterations,
                                          stepSize: stepSize)


print("Lowest error Zeta values found: \(zVals)")

print("Equation with found z values: y = \(zVals[1])x + \(zVals[0])")
