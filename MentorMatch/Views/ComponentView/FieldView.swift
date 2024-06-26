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
    
    var body: some View {
        if type == "settings" {
            VStack(alignment: .leading, spacing: 2) {
                Text(labelText)
                    .font(.headline)
                    .foregroundColor(isError || isError2 ? Color("attention") : Color.gray)
                
                TextField(prevText, text: $text)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(isError || isError2 ? Color("attention") : Color.gray, lineWidth: 8))
                
                    .cornerRadius(15)
                    .keyboardType(keyboardType)
                    .onChange(of: text) { newValue in
                        if newValue.count > maxLength {
                            text = String(newValue.prefix(maxLength))
                        }
                    }
                    .onTapGesture {
                        text = prevText
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
                }
                SecureField(prevText, text: $text)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .keyboardType(keyboardType)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(isError || isError2 ? Color("attention") : Color.gray, lineWidth: 8))
                    .cornerRadius(15)
                
                Text("Пароль должен состоять минимум из 8 символов и включать в себя комбинацию букв верхнего и нижнего регистра латинского алфавита, а также цифры")
                    .font(.caption)
                    .foregroundColor(.gray)
                //                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                
            }
            .onChange(of: text) { newValue in
                isError = !Validator.isPasswordCorrect(password: newValue)
            }
        } else if type == "preUsual" {
            VStack(alignment: .leading, spacing: 2) {
                Text(labelText)
                    .font(.headline)
                    .foregroundColor(isError || isError2 ? Color("attention") : Color.gray)
                TextField(prevText, text: $text, axis: .vertical)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .foregroundColor(.black)
                    .keyboardType(keyboardType)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(isError2 ? Color("attention") : Color.gray, lineWidth: 8))
                    .cornerRadius(15)
                    .lineLimit(30)
                
                if maxLength != 239 {
                    Text("\(text.count)/\(maxLength)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
            }
            .padding(.horizontal, 15)
        }  else if type == "digitals" {
            VStack(alignment: .leading, spacing: 2) {
                Text(labelText)
                    .font(.headline)
                    .foregroundColor(isError || isError2 ? Color("attention") : Color.gray)
                TextField(prevText, text: $text, axis: .vertical)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .foregroundColor(.black)
                    .keyboardType(keyboardType)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(isError || isError2 ? Color("attention") : Color.gray, lineWidth: 8))
                    .cornerRadius(15)
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
                isError = !Validator.isOnlyDigits(newValue)
            }
        }  else if type == "email" {
            VStack(alignment: .leading, spacing: 2) {
                Text(labelText)
                    .font(.headline)
                    .foregroundColor(isError || isError2 ? Color("attention") : Color.gray)
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
                
                if maxLength != 239 {
                    Text("\(text.count)/\(maxLength)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
            }
            .padding(.horizontal, 15)
            .onChange(of: text) { newValue in
                isError = !Validator.isEmailCorrect(newValue)
            }
        } else if type == "passwordLogin" {
            VStack(alignment: .leading, spacing: 2) {
                if labelText != "" {
                    Text(labelText)
                        .font(.headline)
                        .foregroundColor(isError2 ? Color("attention") : Color.gray)
                }
                SecureField(prevText, text: $text)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .keyboardType(keyboardType)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(isError2 ? Color("attention") : Color.gray, lineWidth: 8))
                    .cornerRadius(15)
                
                
            }
            .onChange(of: text) { newValue in
                isError = !Validator.isPasswordCorrect(password: newValue)
            }
        } else if type == "emailLogin" {
            VStack(alignment: .leading, spacing: 2) {
                Text(labelText)
                    .font(.headline)
                    .foregroundColor(isError2 ? Color("attention") : Color.gray)
                TextField(prevText, text: $text, axis: .vertical)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .foregroundColor(.black)
                    .keyboardType(keyboardType)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(isError2 ? Color("attention") : Color.gray, lineWidth: 8))
                    .cornerRadius(15)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                
                if maxLength != 239 {
                    Text("\(text.count)/\(maxLength)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
            }
            .padding(.horizontal, 15)
            .onChange(of: text) { newValue in
                isError = !Validator.isEmailCorrect(newValue)
            }
        }
    }
}

