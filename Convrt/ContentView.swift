//
//  ContentView.swift
//  Convrt
//
//  Created by Nivas Muthu M G on 22/06/21.
//

import SwiftUI

struct Conversion {
    static private let lengthUnits = ["Meters", "KM", "Yards", "Feet", "Miles"]
    static private let temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    static private let volumeUnits = ["MilliLitres", "Litres", "Gallon"]
    
    static let units = ["Length": lengthUnits, "Temperature": temperatureUnits, "Volume": volumeUnits]
    
    static func lengthConversion(sourceValue: Double, sourceUnitIndex: Int, destinationUnitIndex: Int) -> Double {
        var sourceValue = sourceValue
        var result: Double
        
        if sourceUnitIndex == 0{
            sourceValue /= 1000
        } else if sourceUnitIndex == 2 {
            sourceValue /= 1093.6
        } else if sourceUnitIndex == 3 {
            sourceValue /= 3280
        } else if sourceUnitIndex == 4{
            sourceValue /= 0.62137
        }
        
        result = sourceValue
        if destinationUnitIndex == 0 {
            result = sourceValue * 1000
        } else if destinationUnitIndex == 2 {
            result = sourceValue * 1093.6
        } else if destinationUnitIndex == 3 {
            result = sourceValue * 3280
        } else if destinationUnitIndex == 4 {
            result = sourceValue * 0.62137
        }
        
        return result
    }
    
    static func temperatureConversion(sourceValue: Double, sourceUnitIndex: Int, destinationUnitIndex: Int) -> Double {
        var sourceValue = sourceValue
        var result: Double
        
        if sourceUnitIndex == 1 {
            sourceValue = 5/9 * (sourceValue - 32)
        } else if sourceUnitIndex == 2{
            sourceValue -= 273.15
        }
            
        result = sourceValue
        if destinationUnitIndex == 1{
            result = sourceValue * (9/5) + 32
        } else if destinationUnitIndex == 2 {
            result = sourceValue + 273.15
        }
            
        return result
    }
    
    static func volumeConversion(sourceValue: Double, sourceUnitIndex: Int, destinationUnitIndex: Int) -> Double {
        var sourceValue = sourceValue
        var result: Double
        
        if sourceUnitIndex == 0 {
            sourceValue /= 1000
        } else if sourceUnitIndex == 2 {
            sourceValue *= 3.785
        }
        
        result = sourceValue
        if destinationUnitIndex == 0 {
            result = sourceValue * 1000
        } else if destinationUnitIndex == 2{
            result = sourceValue/3.785
        }
        return result
    }
}

struct ContentView: View {
    @State private var source = "0"
    @State private var sourceUnitIndex = 0
    @State private var destinationUnitIndex = 1
    
    private let units = ["Length", "Temperature", "Volume"]
    @State private var unitType = 0
    
    private var result: Double {
        let sourceValue = Double(source) ?? 0
        let result: Double
        if unitType == 0 {
            result = Conversion.lengthConversion(sourceValue: sourceValue, sourceUnitIndex: sourceUnitIndex, destinationUnitIndex: destinationUnitIndex)
        } else if unitType == 1 {
            result = Conversion.temperatureConversion(sourceValue: sourceValue, sourceUnitIndex: sourceUnitIndex, destinationUnitIndex: destinationUnitIndex)
        } else {
            result = Conversion.volumeConversion(sourceValue: sourceValue, sourceUnitIndex: sourceUnitIndex, destinationUnitIndex: destinationUnitIndex)
        }
        return result
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Unit Type", selection: $unitType) {
                        ForEach(0..<units.count) {
                            Text(units[$0])
                        }
                    }
                    .onChange(of: unitType) { _ in
                        destinationUnitIndex = 1
                        sourceUnitIndex = 0
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    TextField("Enter the value", text: $source)
                }
                Section(header: Text("Source Unit")) {
                    Picker("Select the Source Unit", selection: $sourceUnitIndex) {
                        ForEach(0..<Conversion.units[units[unitType]]!.count, id: \.self) {
                            Text(Conversion.units[units[unitType]]![$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Destination Unit")) {
                    Picker("Select the Destination Unit", selection: $destinationUnitIndex) {
                        ForEach(0..<Conversion.units[units[unitType]]!.count, id:\.self) {
                            Text(Conversion.units[units[unitType]]![$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text("\(result, specifier: "%g")")
                }
            }
            .navigationTitle("Convrt")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
