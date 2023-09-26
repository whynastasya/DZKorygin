//
//  WordMixer.swift
//  NumberConverter
//
//  Created by nastasya on 25.09.2023.
//

import SwiftUI

struct WordMixerView: View {
    @State private var result = Result(result: "Здесь будет результат😋", type: .default)
    @State private var startIndex = ""
    @State private var endIndex = ""
    @State private var line = ""
    var body: some View {
        VStack {
            Text(result.result)
                .font(.title2)
                .padding()
                .background(
                    result.type.color.opacity(0.8),
                    in: Capsule())
                .foregroundColor(.white)
                .animation(.spring(), value: result.type)
            
            TextField("Введите предложение", text: $line)
                .textFieldStyle(.roundedBorder)
            
            HStack {
                TextField("С какого слова начать?", text: $startIndex)
                    .textFieldStyle(.roundedBorder)
                TextField("На каком слове закончить?", text: $endIndex)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            
            Button {
                withAnimation {
                    result = line.slice(startIndex: Int(startIndex) ?? -18943, endIndex: Int(endIndex) ?? -18943)
                }
            } label: {
                HStack {
                    Image(systemName: "text.append")
                    Text("Перемешать")
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple.opacity(0.1))
        }
        .padding()
    }
}

struct WordMixerView_Previews: PreviewProvider {
    static var previews: some View {
        WordMixerView()
    }
}
