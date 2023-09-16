//
//  ScanView.swift
//  Hach2023_new
//
//  Created by Dosi Dimitrov on 16.09.23.
//

import SwiftUI
import CodeScanner
import CryptoKit

struct ScanView: View {
    
    @State private var isPresentingScanner = false
    @State var name : String = ""
    @State var index : Bool = false
    
    var body: some View {
        VStack {
            
            if !name.isEmpty{
                Text("Hash:")
            }
         
            Text(getHash())
                .font(.system(size: 20))
            Spacer()
            
            if !name.isEmpty {
                Image(index ? "ok" : "not")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
            }

            Text(name)
                .foregroundColor(.gray)
                .font(.system(size: 20))
            Button(action: {
                
                self.isPresentingScanner.toggle()
                
            }, label: {
                Text("Scanning")
                    .padding()
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 10)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
            })
        }
        .sheet(isPresented: $isPresentingScanner){ scannerSheet }
        .padding()
        .onAppear(){
            name = ""
        }
    }
    
    var scannerSheet: some View {
        CodeScannerView(codeTypes: [.qr] , completion: { result in
            switch result {
            case .success(let res) :
                print("\(res)")
                self.name = res.string
            
                self.isPresentingScanner = false
                self.index.toggle()
                
            case .failure(let err):
                print("\(err)")
                self.isPresentingScanner = false
            }
        })
    }
    
    func getHash() -> String {
        if !name.isEmpty {
            
            let inputData = Data(name.utf8)
            let hashed = SHA256.hash(data: inputData)
            let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
            return  hashString
            
        }else{
            return ""
        }

    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
