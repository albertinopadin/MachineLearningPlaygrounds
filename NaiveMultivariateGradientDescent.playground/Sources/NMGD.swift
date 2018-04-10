import Foundation

func hypothesis(zValues: [Double], xValue: Double) -> (Double) {
    var result = 0.0
    
    for exponent in 0..<zValues.count {
        result += zValues[exponent] * pow(xValue, Double(exponent))
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

public func naiveMultivariateGradientDescent(initialZValues: [Double],
                                             xValues: [Double],
                                             yValues: [Double],
                                             maxIterations: Int,
                                             stepSize: Double) -> [Double] {
    
    var predictedYs = [Double?](repeating: nil, count: xValues.count)
    var minimumErrorFound = [Bool](repeating: false, count: initialZValues.count)
    var zVals: [Double] = initialZValues
    
    // Gradient descent loop:
    for _ in 0...maxIterations {
        for xs in xValues {
            predictedYs[Int(xs)] = hypothesis(zValues: zVals, xValue: xs)
        }
        
        // Update cost function for each z-value simultaneously:
        let currentZValues = zVals
        var currentXValues = xValues
        
        for i in 0..<currentZValues.count {
            
            if i == 0 {
                currentXValues = currentXValues.map { _ in return Double(1.0) }
            } else {
                currentXValues = xValues
            }
            
            let cFd = costFunctionPartialDerivative(xValues: currentXValues,
                                                    actualYs: yValues,
                                                    predictedYs: predictedYs as! [Double])
            print("Cost Fn for Z \(i) = \(cFd)")
            
            let expandedCFD = cFd * 10e14
            
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
            break
        }
    }
    
    return zVals
}
