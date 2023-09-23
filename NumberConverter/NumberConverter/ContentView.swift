//
//  ContentView.swift
//  NumberConverter
//
//  Created by nastasya on 21.09.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var numbers = Numbers.createNumbersDictionary()
    @State private var numberString = ""
    @State var result: String = ""
    
    var body: some View {
        VStack {
            Text(result)
            TextField("Введите Ваше число прописью", text: $numberString)
                .textFieldStyle(.roundedBorder)
            
            Button("convert") {
                result = NumberConverter.checkConditions(numberString: numberString)
            }
            .buttonStyle(.bordered)
            .tint(.purple)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(result: "")
    }
}
