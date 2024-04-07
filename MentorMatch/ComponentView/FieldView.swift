//
//  SettingsFieldView.swift
//  MentorMatch
//
//  Created by Тася Галкина on 10.03.2024.
//

import Foundation
import SwiftUI

struct FieldView: View {
    
    @State var isError: Bool
    var isError2: Bool
    let maxLength: Int
    let labelText: String
    let type: String
    let prevText: String
    let keyboardType: UIKeyboardType
    @Binding var text: String
    
    /*@State private */
   // @State private var hideText: String = ""
    //@State private var text: String = ""
    
//    init(maxLength: Int = 239, labelText: String = "", prevText: String, type: String, keyboardType: UIKeyboardType = .default, text: String) {
//        //self.hideText = prevText
//        self.maxLength = maxLength
//        self.labelText = labelText
//        self.prevText = prevText
//        self.type = type
//        self.keyboardType = keyboardType
//        self.text = text
//    }
    
    var body: some View {
        if type == "settings" {
            VStack(alignment: .leading, spacing: 2) {
                Text(labelText)
                    .font(.headline)
                    .foregroundColor(isError || isError2 ? Color("attention") : Color.gray)
//                    .foregroundColor(isError ? Color("attention") : Color.gray)
//                    .foregroundColor(isError2 ? Color("attention") : Color.gray)
                
                TextField(prevText, text: $text)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(isError ? Color("attention") : Color.gray, lineWidth: 8)) // Изменяем цвет рамки в зависимости от ошибки

                    .cornerRadius(15)
                    .keyboardType(keyboardType)
                    .onChange(of: text) { newValue in
                        if newValue.count > maxLength {
                            text = String(newValue.prefix(maxLength))
                        }
                    }
                    .onTapGesture {
                                text = prevText
//                        isError = false
                        // Сохраняем предыдущее значение при нажатии
                            }
                if maxLength != 239 {
                    Text("\(text.count)/\(maxLength)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
            }
            .padding(.horizontal, 15)
        } else if type == "usual" {
            VStack(alignment: .leading, spacing: 2) {
                TextField(prevText, text: $text, axis: .vertical)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .foregroundColor(.black)
                    .keyboardType(keyboardType)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(isError ? Color("attention") : Color.gray, lineWidth: 8))
                    .cornerRadius(15)
                    //.padding(.horizontal, 15)
                    //.padding(.top, 100)
                    .lineLimit(30)
                    
                if maxLength != 239 {
                    Text("\(text.count)/\(maxLength)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
            }
            .padding(.horizontal, 15)
        } else if type == "password" {
            VStack(alignment: .leading, spacing: 2) {
                if labelText != "" {
                    Text(labelText)
                        .font(.headline)
                        .foregroundColor(isError || isError2 ? Color("attention") : Color.gray)
    //                    .foregroundColor(isError ? Color("attention") : Color.gray)
    //                    .foregroundColor(isError2 ? Color("attention") : Color.gray)
                }
                SecureField(prevText, text: $text)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .keyboardType(keyboardType)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(isError || isError2 ? Color("attention") : Color.gray, lineWidth: 8))
//                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(isError2 ? Color("attention") : Color.gray, lineWidth: 8))
                    .cornerRadius(15)
                    //.padding(.horizontal, 15)
                    //.padding(.top, 10)
                
                Text("Пароль должен состоять минимум из 8 символов и включать в себя комбинацию букв верхнего и нижнего регистра латинского алфавита, а также цифры")
                    .font(.caption)
                    .foregroundColor(.gray)
//                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                
            }
            .onChange(of: text) { newValue in
                    // Проверяем корректность электронной почты и устанавливаем значение isError
                    isError = !Validator.isPasswordCorrect(password: newValue)
                }
            //.padding(.horizontal, 15)
            
            //.padding(.vertical, 2)
        } else if type == "preUsual" {
            VStack(alignment: .leading, spacing: 2) {
                Text(labelText)
                    .font(.headline)
                    .foregroundColor(isError || isError2 ? Color("attention") : Color.gray)
//                    .foregroundColor(isError ? Color("attention") : Color.gray)
//                    .foregroundColor(isError2 ? Color("attention") : Color.gray)
                TextField(prevText, text: $text, axis: .vertical)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .foregroundColor(.black)
                    .keyboardType(keyboardType)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(isError2 ? Color("attention") : Color.gray, lineWidth: 8))
                    .cornerRadius(15)
                    //.padding(.horizontal, 15)
                    //.padding(.top, 100)
                    .lineLimit(30)
                    
                if maxLength != 239 {
                    Text("\(text.count)/\(maxLength)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
            }
            .padding(.horizontal, 15)
//            .onChange(of: text) { newValue in
//                    // Проверяем корректность электронной почты и устанавливаем значение isError
//                isError2 = !Validator.isNotEmpty(newValue)
//                }
            
            //.padding(.vertical, 2)
        }  else if type == "digitals" {
            VStack(alignment: .leading, spacing: 2) {
                Text(labelText)
                    .font(.headline)
                    .foregroundColor(isError || isError2 ? Color("attention") : Color.gray)
//                    .foregroundColor(isError ? Color("attention") : Color.gray)
//                    .foregroundColor(isError2 ? Color("attention") : Color.gray)
                TextField(prevText, text: $text, axis: .vertical)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .foregroundColor(.black)
                    .keyboardType(keyboardType)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(isError || isError2 ? Color("attention") : Color.gray, lineWidth: 8))
                    .cornerRadius(15)
                    //.padding(.horizontal, 15)
                    //.padding(.top, 100)
                    .lineLimit(30)
                    
                if maxLength != 239 {
                    Text("\(text.count)/\(maxLength)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
            }
            .padding(.horizontal, 15)
            .onChange(of: text) { newValue in
                    // Проверяем корректность электронной почты и устанавливаем значение isError
                    isError = !Validator.isOnlyDigits(newValue)
                }
            
            //.padding(.vertical, 2)
        }  else if type == "email" {
            VStack(alignment: .leading, spacing: 2) {
                Text(labelText)
                    .font(.headline)
//                    .foregroundColor(Color.gray)
                    .foregroundColor(isError || isError2 ? Color("attention") : Color.gray)
//                    .foregroundColor(isError2 ? Color("attention") : Color.gray)
                TextField(prevText, text: $text, axis: .vertical)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .foregroundColor(.black)
                    .keyboardType(keyboardType)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(isError || isError2 ? Color("attention") : Color.gray, lineWidth: 8))
                    .cornerRadius(15)
                .textContentType(.emailAddress)
                .autocapitalization(.none)
                    //.padding(.horizontal, 15)
                    //.padding(.top, 100)
                   // .lineLimit(30)
                    
                if maxLength != 239 {
                    Text("\(text.count)/\(maxLength)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
            }
            .padding(.horizontal, 15)
            .onChange(of: text) { newValue in
                    // Проверяем корректность электронной почты и устанавливаем значение isError
                    isError = !Validator.isEmailCorrect(newValue)
                }
            //.padding(.vertical, 2)
        }
    }
}
    
    
//    struct FieldView_Previews: PreviewProvider {
//        static var previews: some View {
//            FieldView(maxLength: 239, labelText: "Описание", prevText: "Таисия", type: "usual", keyboardType: .numberPad, text: <#Binding<String>#>)
//            //            .previewLayout(.sizeThatFits)
//            //            .padding()
//        }
//    }
    
    
