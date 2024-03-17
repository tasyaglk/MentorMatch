//
//  YearPickerTextField.swift
//  MentorMatch
//
//  Created by Тася Галкина on 13.03.2024.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @State private var showPicker = false
    @State private var selectedYear = 2024
    let years = Array(2000...2030)

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 2) {
                Text("Select Year")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                NavigationLink(destination: YearPickerView(selectedYear: $selectedYear, showPicker: $showPicker, years: years), isActive: $showPicker) {
                    Text("\(selectedYear)")
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 1))
                        .onTapGesture {
                            showPicker = true
                        }
                }
            }
            .padding()
            .navigationBarTitle("Year Picker")
        }
    }
}

struct YearPickerView: View {
    @Binding var selectedYear: Int
    @Binding var showPicker: Bool
    let years: [Int]

    var body: some View {
        VStack {
            Picker(selection: $selectedYear, label: Text("")) {
                ForEach(years, id: \.self) { year in
                    Text("\(year)").tag(year)
                }
            }
            .labelsHidden()
            .padding()
            .frame(height: 150)
            .clipped()

            Button("Done") {
                showPicker = false
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
