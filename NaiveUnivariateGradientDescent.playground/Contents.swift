//: Playground - noun: a place where people can play

//
//  NaiveGradientDescent
//
//  Created by Albertino Padin on 4/6/18.
//  Copyright © 2018 Albertino Padin. All rights reserved.
//

import Foundation

// EXTREMELY Naive Gradient Descent
// This is the linear relationship y = x. Very simple.
// Generalized, it is y = mx, where m = 1.
// This algorithm naively attempts gradient descent to find the correct m, starting at a specified value.

let xValues: [Double] = [0, 1, 2, 3]
let yValues: [Double] = [0, 1, 2, 3]

func zFunction(zValue: Double, xValue: Double) -> (Double) {
    return zValue * xValue
}

func costFunctionDerivative(actualYs: [Double], predictedYs: [Double]) -> Double {
    var errorSum: Double = 0.0
    
    for (aYs, pYs) in zip(actualYs, predictedYs) {
        errorSum += Double(pYs - aYs)
    }
    
    let m: Double = Double(actualYs.count)
    return errorSum / m
}


let zStart: Double = -100

let stepSize: Double = 1.0
let maxIterations = 1000
var predictedYs = [Double?](repeating: nil, count: xValues.count)

var zVal: Double = zStart

// Gradient descent loop:
for _ in 0...maxIterations {
    for xs in xValues {
        predictedYs[Int(xs)] = zFunction(zValue: zVal, xValue: xs)
    }
    
    let cFd = costFunctionDerivative(actualYs: yValues, predictedYs: predictedYs as! [Double])
    print("Cost Function result for zVal: \(zVal) is \(cFd)")
    
    let expandedCFD = cFd * 10e14
    
    if expandedCFD.rounded(.towardZero) == 0.0 {
        // Found minimal error zVal!
        print("Found minimal error zVal: \(zVal)")
        break
    }
    
    zVal -= stepSize * cFd
}

print("Lowest error Zeta value found: \(zVal)")



