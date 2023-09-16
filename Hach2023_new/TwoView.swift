//
//  TwoView.swift
//  Hach2023_new
//
//  Created by Dosi Dimitrov on 16.09.23.
//

import SwiftUI
import CodeScanner
import CryptoKit

struct TwoView: View {
    
    @State var hashString : String = ""
    @State private var isPresentingScanner = false
    
    var body: some View {
        VStack {
            Text("Certificate")
                .font(.system(size: 50))
                .shadow(color: .gray, radius: 10, x: 10, y: 0)
            Image("Rich")
                .resizable()
                .scaledToFit()
                .frame(width: 200,height: 200)
            HStack {
                Text("Name: ")
                Spacer()
                Text("SANTOS DE CARTIER")
            }
            .padding(.horizontal, 50)
            HStack {
                Text("Producer: ")
                Spacer()
                Text("Cartier")
            }
            .padding(.horizontal, 50)
            HStack {
                Text("Year:")
                Spacer()
                Text("2023")
            }
            .padding(.horizontal, 50)
            HStack {
                Text("Seriennnummer: ")
                Spacer()
                Text("WSSA0029")
            }
            .padding(.horizontal, 50)
            HStack {
                Text("Gehäuse:")
                Spacer()
                Text("Edelstahl")
            }
            .padding(.horizontal, 50)
            
            
            if !hashString.isEmpty {
                VStack{
                    Text("hash:\n \(getHash())")
                        .font(.system(size: 8))
                        .padding(.horizontal, 10)
                    QRCodeView(url: hashString)
                    Text("scan for verify")
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1))
               
            }
            Spacer()
            Button(action: {
                
                hashString = "Name:SANTOS DE CARTIER Producer:Cartier Year:2023 Seriennnummer:WSSA0029 Gehäuse:Edelstahl"
                print(getHash())
                
            }, label: {
                      Text("Encrypt JSON data")
                          .padding()
                          .foregroundColor(.black)
                          .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.5)))
            })
            
        }
    }
    func getHash() -> String {
        
        let inputData = Data(hashString.utf8)
        let hashed = SHA256.hash(data: inputData)
        let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
        return  hashString
      
        
    }
    
}

struct TwoView_Previews: PreviewProvider {
    static var previews: some View {
        TwoView()
    }
}
