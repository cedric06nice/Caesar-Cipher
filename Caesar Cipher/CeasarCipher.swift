//
//  CeasarCipher.swift
//  Caesar Cipher
//
//  Created by Cedric on 01/07/2020.
//  Copyright © 2020 cedric06nice. All rights reserved.
//

import Foundation

class CaesarCipher {
    // MARK: - encipher
    
    class func encipher(text: String, shiftBy: UInt32) -> String
    {
        return Array(text.uppercased().unicodeScalars)
            .map        { self.encipherCharValue(charValue: $0.value, shiftBy: shiftBy) }
            .reduce("") { $0 + letterFromValue(value: $1) }
    }
    
    private class func encipherCharValue(charValue: UInt32, shiftBy: UInt32) -> UInt32
    {
        return Letters.isUppercaseLetterValue(charValue: charValue)
            ? encipherLetterValue(letterValue: charValue, shiftBy: shiftBy)
            : charValue
    }
    
    private class func encipherLetterValue(letterValue: UInt32, shiftBy: UInt32) -> UInt32
    {
        let shiftedValue = (letterValue - Letters.A) + shiftBy
        return Letters.A + (shiftedValue % 26)
    }
    
    private class func letterFromValue(value: UInt32) -> String
    {
        return String(Character(UnicodeScalar(value)!))
    }
    
    // MARK: - decipher
    /*
    
    class func decipher(text: String, letterFrequencies: [Double]) -> String?
    {
        let freqTable  = createLetterFrequencyTable(text: text)
        let chiSquares = freqTable.map { self.chiSquare(observed: $0, letterFrequencies) }
        let minValue   = chiSquares.min()
        let shiftBy    = find(chiSquares, minValue)!
        let confident  = minValue < 2.0 // Allow only a small degree of uncertainty.
        return confident ? encipher(text, shiftBy: UInt32(shiftBy)) : nil
    }
    
    private class func createLetterFrequencyTable(text: String) -> [[Double]]
    {
        return Array(0..<26).map { (shiftBy: UInt32) -> [Double] in
            let encipheredText  = self.encipher(text: text, shiftBy: shiftBy)
            let encipheredWords = encipheredText.components(separatedBy: " ")
            return LetterFrequency.analyzeWords(words: encipheredWords)
        }
    }
    
    // Calculates the degree of difference between observed and expected values.
    private class func chiSquare(observed: [Double], _ expected: [Double]) -> Double
    {
        return Array(zip(observed, expected))
            .reduce(0.0) { (sum, values) in
                let delta = values.0 - values.1
                return sum + ((delta * delta) / values.1)
        }
    }
    */
}


struct Letters
{
    static let
    A: UInt32 =  65,
    Z: UInt32 = 101
    
    static func isUppercaseLetterValue(charValue: UInt32) -> Bool
    {
        return Letters.A <= charValue && charValue <= Letters.Z
    }
}


extension String
{
    func toLetters() -> [String]
    {
        return Array(self.unicodeScalars)
            .filter { Letters.isUppercaseLetterValue(charValue: $0.value) }
            .map { String($0) }
    }
}


class LetterFrequency
{
    class func analyzeWords(words: [String]) -> [Double]
    {
        let letters = words
            .reduce("") { $0 + $1.uppercased() }
            .toLetters()
        
        let letterCount = max(letters.count, 1)
        
        let occurrences = NSCountedSet()
        occurrences.addObjects(from: letters)
        
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".toLetters()
        return alphabet.map {
            Double(occurrences.count(for: $0)) / Double(letterCount)
        }
    }
}
