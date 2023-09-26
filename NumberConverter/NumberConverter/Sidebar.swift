//
//  Sidebar.swift
//  NumberConverter
//
//  Created by nastasya on 25.09.2023.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: NumberConverterView()) {
                    Label("Конвертер чисел", systemImage: "123.rectangle")
                }
                NavigationLink(destination: WordMixerView()) {
                    Label("Миксер слов", systemImage: "text.insert")
                }
            }
            .navigationTitle("Домашние задания")
        }
        .navigationTitle("Домашние задания")
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
