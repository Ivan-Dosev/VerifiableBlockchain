//
//  OneView.swift
//  Hach2023_new
//
//  Created by Dosi Dimitrov on 16.09.23.
//

import SwiftUI
import web3swift
import  CryptoKit

struct OneView: View {
    
    @State var suit: University = .ETHZurich
    @State var nameIndex : Int = -1
    @State var qrcodeString : String = ""
    
    
    
    @StateObject var vm = Arad()
    
    var body: some View {
        ScrollView{
            VStack {

                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .padding()


                Picker(suit.rawValue, selection: $suit) {
                    ForEach(University.allCases, id: \.self) { suit in
                        Text(suit.rawValue)
                            .tag(suit)
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
                .pickerStyle(MenuPickerStyle())
                .tint(.black)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.gray)
                        .opacity(0.3)
                )
                .onChange(of: suit) { uti in
                    vm.name = uti.mimi()
                    print("\(uti.mimi())")
                }
                .overlay(
                    HStack{
                        Text("Select University")
                            .foregroundColor(.gray)
                            .offset(y: -45)
                       // Spacer()
                    }
                        .padding(.horizontal, 30)

                )
             
                VStack{
                    
                    ForEach(Array(zip(vm.name, vm.name.indices)), id: \.0) { index, count in
                        HStack{
                            Text(index)
                                .onTapGesture {
                                    nameIndex = count
                                    qrcodeString = index
                                        
                                }
                 

                        }
                        .frame(height: 50)
                        .foregroundColor(nameIndex == count ? .red : .black)

                    }
                }.frame(width: UIScreen.main.bounds.width / 2)
            

            }
            .padding()
            if !qrcodeString.isEmpty {
                VStack{
                    Text("hash:\n \(getHash())")
                        .font(.system(size: 8))
                        .padding(.horizontal, 10)
                    QRCodeView(url: qrcodeString)
                    Text("scan for verify")
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 1))
               
            }
          
        }

    }
    func getHash() -> String {
        
        let inputData = Data(qrcodeString.utf8)
        let hashed = SHA256.hash(data: inputData)
        let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
        print(hashString)
        return  hashString
      
        
    }
}

struct OneView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension Data {
    var hexDescription: String {
        return reduce("") {$0 + String(format: "%02x", $1)}
    }
}
