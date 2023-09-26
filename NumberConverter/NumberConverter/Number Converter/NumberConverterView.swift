//
//  NumberConverterView.swift
//  NumberConverter
//
//  Created by nastasya on 25.09.2023.
//

import SwiftUI

struct NumberConverterView: View {
    @State private var numberString = ""
    @State var result = Result(result: "Здесь будет результат😋", type: .default)
    
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
            
            TextField("Введите Ваше число прописью", text: $numberString)
                .textFieldStyle(.roundedBorder)
            
            Button {
                withAnimation {
                    result = NumberConverter.checkConditions(numberString: numberString)
                }
            } label: {
                HStack {
                    Image(systemName: "123.rectangle")
                    Text("Конвертнуть")
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple.opacity(0.1))
        }
        .padding()
    }
}


struct NumberConverterView_Previews: PreviewProvider {
    static var previews: some View {
        NumberConverterView()
    }
}
