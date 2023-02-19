//
//  PaymentView.swift
//  Crypto
//
//  Created by qwotic on 14.02.2023.
//

import SwiftUI
import CoreData

struct PaymentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \Card.number, ascending: true),
        NSSortDescriptor(keyPath: \Card.name, ascending: true)
    ]) var cards: FetchedResults<Card>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        List {
            ForEach(cards){ card in
                NavigationLink(destination: DetailCardView(card: card)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(card.name ?? "Unknown Name")
                                .font(.headline)

                            Text(card.number ?? "Unknown Number")
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("Date")
                                .foregroundColor(.secondary)
                            
                            Text(card.date ?? "Unknow Date")
                        }
                    }
                }
            }
            .onDelete(perform: deleteCard)
        }
        .navigationTitle("Payment")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddScreen.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingAddScreen) { AddCardView() }
    }
    
    func deleteCard(at offsets: IndexSet) {
        for offset in offsets {
            let card = cards[offset]
            moc.delete(card)
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

