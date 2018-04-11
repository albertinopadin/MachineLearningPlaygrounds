import Foundation

func batcHypothesis(zValues: [Double], xValues: [Double]) -> [Double] {
    var predicted = [Double?](repeating: nil, count: xValues.count)
    
    for i in 0..<xValues.count {
        predicted[i] = hypothesisFunction(zValues: zValues, xValue: xValues[i])
    }
    
    return predicted as! [Double]
}

func hypothesisFunction(zValues: [Double], xValue: Double) -> Double {
    var result = 0.0
    
    for i in 0..<zValues.count {
        if i == 0 {
            result += zValues[i]
        } else {
            result += zValues[i] * xValue
        }
    }
    
    return result
}

func costFunctionPartialDerivative(xValues: [Double], actualYs: [Double], predictedYs: [Double]) -> Double {
    var errorSum: Double = 0.0
    
    for (xVal, (aY, pY)) in zip(xValues, zip(actualYs, predictedYs)) {
        errorSum += Double(pY - aY) * xVal
    }
    
    let m: Double = Double(actualYs.count)
    return errorSum / m
}

func scaleAndNormalizeValues(values: [Double]) -> [Double] {
    let range = values.max()! - values.min()!
    let average = values.reduce(0, +) / Double(values.count)
    return values.map { ($0 - average) / range }
}

public func scaledMultivariateGradientDescent(initialZValues: [Double],
                                             xValues: [Double],
                                             yValues: [Double],
                                             maxIterations: Int,
                                             stepSize: Double) -> [Double] {
    
    var predictedYs = [Double]()
    var minimumErrorFound = [Bool](repeating: false, count: initialZValues.count)
    var zVals: [Double] = initialZValues
    let scaledXValues = scaleAndNormalizeValues(values: xValues)
    
    // Gradient descent loop:
    for iteration in 0...maxIterations {
        predictedYs = batcHypothesis(zValues: zVals, xValues: xValues)
        
        // Update cost function for each z-value simultaneously:
        let currentZValues = zVals
        var currentXValues = [Double]()
        
        for i in 0..<currentZValues.count {
            
            if i == 0 {
                currentXValues = scaledXValues.map { _ in return Double(1.0) }
            } else {
                currentXValues = scaledXValues
            }
            
            let cFd = costFunctionPartialDerivative(xValues: currentXValues,
                                                    actualYs: yValues,
                                                    predictedYs: predictedYs)
            print("Cost Fn for Z \(i) = \(cFd)")
            
            let expandedCFD = cFd * 10e13
            
            if expandedCFD.rounded(.towardZero) == 0.0 {
                // Found minimal error zVal!
                print("Found minimal error for zVal: \(i) at: \(zVals[i])")
                minimumErrorFound[i] = true
                continue
            }
            
            if !minimumErrorFound.contains(false) {
                // Break out of loop as we have found all minimum errors.
                break
            }
            
            zVals[i] -= stepSize * cFd
        }
        
        if !minimumErrorFound.contains(false) {
            // Break out of loop as we have found all minimum errors.
            print("Total iterations: \(iteration)")
            break
        }
    }
    
    return zVals
}
