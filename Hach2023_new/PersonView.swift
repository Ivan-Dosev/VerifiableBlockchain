//
//  PersonView.swift
//  Hach2023_new
//
//  Created by Dosi Dimitrov on 16.09.23.
//

import SwiftUI
import Combine
//import metamask_ios_sdk

extension Notification.Name {
    static let Event = Notification.Name("event")
    static let Connection = Notification.Name("connection")
    static let Dossi = Notification.Name("urlDossi")
    static let Arda = Notification.Name("urlArda")
}

struct PersonView: View {
    @ObservedObject var ethereum = MetaMaskSDK.shared.ethereum
  //  @StateObject var client = SocketClient(store: Keychain(service: SDKInfo.bundleIdentifier), tracker: Analytics(debug: true))
  
  
    @State var dossiString : String = ""
    @State var ardaString : String = ""
    
    @State private var cancellables: Set<AnyCancellable> = []

    private let dapp = Dapp(name: "Dub Dapp", url: "https://dubdapp.com")

    @State private var connected: Bool = false
    @State private var status: String = "Offline"

    @State private var errorMessage = ""
    @State private var showError = false

    @State private var showProgressView = false
    @State private var showToast = false

    var body: some View {
        NavigationView {
            List {
                Section {
                    Group {
                        HStack {
                            Text("Status")
                                .bold()
                                .font(.system(.caption, design: .rounded))
                                .foregroundColor(.black)
                            Spacer()
                            Text(status)
                                .font(.system(.caption, design: .rounded))
                                .foregroundColor(.black)
                        }

                        HStack {
                            Text("Chain ID")
                                .bold()
                                .font(.system(.callout, design: .rounded))
                                .foregroundColor(.black)
                            Spacer()
                            Text(ethereum.chainId)
                                .font(.system(.caption, design: .rounded))
                                .foregroundColor(.black)
                        }

                        HStack {
                            Text("Account")
                                .bold()
                                .font(.system(.callout, design: .rounded))
                                .foregroundColor(.black)
                            Spacer()
                            Text(ethereum.selectedAddress)
                                .font(.system(.caption, design: .rounded))
                                .foregroundColor(.black)
                        }
                       VStack{
                           HStack{
                               Spacer()
                               if !dossiString.isEmpty {
                                   QRCodeView(url: dossiString)
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 5).foregroundColor(Color.brown))
                                .opacity(!ardaString.isEmpty ? 0.2 : 1)
                                }
                               Spacer()
                           }

                           
                           if !ardaString.isEmpty {
                               QRCodeView(url: ardaString)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(lineWidth: 5).foregroundColor(Color.brown))
                           }else{
                               
                           }
                      
                       }
                    }
                }

                if !ethereum.selectedAddress.isEmpty {
                    Section {
                        Group {
                            NavigationLink("Sign") {
                                SignView()
                            }

                            NavigationLink("Transact") {
                                TransactionView()
                            }

                            NavigationLink("Switch chain") {
                                SwitchChainView()
                            }
                            
                            Button {
                                ethereum.clearSession()
                                showToast = true
                            } label: {
                                Text("Clear Session")
                                    .font(.system(.body, design: .rounded))
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, maxHeight: 32)
                            }
                           .toast(isPresented: $showToast) {
                               ToastView(message: "Session cleared")
                           }
                           // .modifier(ButtonStyle())
                        }
                    }
                }
                
                if ethereum.selectedAddress.isEmpty {
                    Section {
                        ZStack {
                            Button {
                                showProgressView = true
                             
                             ethereum.connect(dapp)?.sink(receiveCompletion: { completion in
                                 switch completion {
                                 case let .failure(error):
                                     showProgressView = false
                                     errorMessage = error.localizedDescription
                                     showError = true
                                     print("Connection error: \(errorMessage)")
                                 default: break
                                 }
                             }, receiveValue: { result in
                                 showProgressView = false
                                 print("Connection result: \(result)")
                             }).store(in: &cancellables)
                                
                            } label: {
                                Text("Connect to MetaMask")
                                    .font(.system(.body, design: .rounded))
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, maxHeight: 32)
                            }
                           // .modifier(ButtonStyle())

                            if showProgressView && !ethereum.connected {
                                ProgressView()
                                    .scaleEffect(1.5, anchor: .center)
                                    .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            }
                        }
                        .alert(isPresented: $showError) {
                            Alert(
                                title: Text("Error"),
                                message: Text(errorMessage)
                            )
                        }
                    } footer: {
                        Text("This will open the MetaMask app. Please sign in and accept the connection prompt.")
                            .font(.system(.caption, design: .rounded))
                            .foregroundColor(.black)
                    }
                }
            }
            .font(.body)
           .onReceive(NotificationCenter.default.publisher(for: .Connection)) { notification in
               status = notification.userInfo?["value"] as? String ?? "Offline"
           }
            .onReceive(NotificationCenter.default.publisher(for: .Dossi)) { notification in
                dossiString = notification.userInfo?["value"] as? String ?? ""
            }
            .onReceive(NotificationCenter.default.publisher(for: .Arda)) { notification in
                ardaString = notification.userInfo?["value"] as? String ?? ""
            }
            .navigationTitle("")
        }
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView()
    }
}
