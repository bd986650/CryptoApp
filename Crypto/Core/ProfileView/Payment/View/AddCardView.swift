//
//  AddCardView.swift
//  Crypto
//
//  Created by qwotic on 14.02.2023.
//

import SwiftUI

struct AddCardView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode

    @State private var degress: Double = 0
    @State private var flipped: Bool = false
    
    @State private var name: String = ""
    @State private var number: String = ""
    @State private var date: String = ""
    @State private var cvv: String = ""
    
    @FocusState private var focusNameTF: Bool
    @FocusState private var focusNumberTF: Bool
    @FocusState private var focusDateTF: Bool
    @FocusState private var focusCVVTF: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                CardView{
                    VStack {
                        Group {
                            if flipped {
                                CardBackView(cvv: cvv)
                            } else {
                                CardFrontView(name: name, cardNumber: number, date: date)
                            }
                        }
                        .rotation3DEffect(.degrees(degress),
                                          axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                    
                }
                .onTapGesture {
                    withAnimation(.spring()){
                        degress += 180
                        flipped.toggle()
                    }
                }
                
                Form {
                    Section {
                        HStack {
                            TextField("YOUR NAME", text: $name)
                                .focused($focusNameTF)
                            
                            Circle()
                                .frame(width: 22)
                                .foregroundColor(focusNameTF ? .white : .gray.opacity(0.2))
                        }
                    }
                    
                    Section {
                        HStack {
                            TextField("CARD NUMBER", text: $number).font(.headline)
                                .keyboardType(.numberPad)
                                .focused($focusNumberTF)
                            
                            Circle()
                                .frame(width: 22)
                                .foregroundColor(focusNumberTF ? .white : .gray.opacity(0.2))
                        }
                    }
                    
                    Section {
                        HStack {
                            TextField("Date", text: $date)
                                .focused($focusDateTF)
                            Circle()
                                .frame(width: 22)
                                .foregroundColor(focusDateTF ? .white : .gray.opacity(0.2))
                        }
                    }
                    
                    Section {
                        HStack {
                            TextField("CVV", text: $cvv) { (editingChanged) in
                                
                                if editingChanged {
                                    withAnimation(.spring()){
                                        degress += 180
                                        flipped.toggle()
                                    }
                                } else {
                                    withAnimation(.spring()){
                                        degress += 180
                                        flipped.toggle()
                                    }
                                }
                                
                            }
                            .focused($focusCVVTF)
                            
                            Circle()
                                .frame(width: 22)
                                .foregroundColor(focusCVVTF ? .white : .gray.opacity(0.2))
                        }
                    }
                }
                
                
                Spacer()
                
                Button {
                    let newCard = Card(context: moc)
                    newCard.id = UUID()
                    newCard.name = name
                    newCard.date = date
                    newCard.number = number
                    newCard.cvv = cvv
                    
                    try? moc.save()
                    dismiss()
                } label: {
                    Text("ADD")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .padding(4)
                        .padding(.horizontal, 20)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .background(checkCard() ? .green : .gray.opacity(0.2))
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Add Card")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func checkCard() -> Bool {
        return name != "" && number != "" && date != "" && cvv != ""
    }
}
