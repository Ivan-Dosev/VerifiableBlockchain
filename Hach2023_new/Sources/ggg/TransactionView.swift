//
//  TransactionView.swift
//  metamask-ios-sdk_Example
//

import SwiftUI
import Combine
//import metamask_ios_sdk

struct TransactionView: View {
    @ObservedObject var ethereum: Ethereum = MetaMaskSDK.shared.ethereum
// 16345785D8A0000
    @State private var amount = "0x16345785D8A0000"
    @State var result: String = "0xa6f2ae3a" // func buy
    @State private var errorMessage = ""
    @State private var showError = false
    @State private var cancellables: Set<AnyCancellable> = []
    @State private var to = "0xAd566276CFA8D226faEC6F6aAf7b7f2fD158D67F"

    var body: some View {
        Form {
            Section {
                Text("From")
                   // .modifier(TextCallout())
                TextField("Enter sender address", text: $ethereum.selectedAddress)
                   // .modifier(TextCaption())
                    .frame(minHeight: 32)
                   // .modifier(TextCurvature())
            }

            Section {
                Text("To")
                  //  .modifier(TextCallout())
                TextEditor(text: $to)
                   // .modifier(TextCaption())
                    .frame(minHeight: 32)
                  //  .modifier(TextCurvature())
            }

            Section {
                Text("Amount")
                   // .modifier(TextCallout())
                TextField("Amount", text: $amount)
                   // .modifier(TextCaption())
                    .frame(minHeight: 32)
                  //  .modifier(TextCurvature())
            }

            Section {
                Text("Result")
                   // .modifier(TextCallout())
                TextEditor(text: $result)
                   // .modifier(TextCaption())
                    .frame(minHeight: 40)
                   // .modifier(TextCurvature())
            }

            Section {
                Button {
                    sendTransaction()
                } label: {
                    Text("Send transaction")
                       // .modifier(TextButton())
                        .frame(maxWidth: .infinity, maxHeight: 32)
                }
                .alert(isPresented: $showError) {
                    Alert(
                        title: Text("Error"),
                        message: Text(errorMessage)
                    )
                }
               // .modifier(ButtonStyle())
            }
        }
        .background(Color.blue.grayscale(0.5))
    }

    func sendTransaction() {
        let transaction = Transaction(
            to:    to,
            from:  ethereum.selectedAddress,
            value: amount,
            data:  result
        )

        let transactionRequest = EthereumRequest(
            method: .ethSendTransaction,
            params: [transaction] // eth_sendTransaction rpc call expects an array parameters object
        )

        ethereum.request(transactionRequest)?.sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                errorMessage = error.localizedDescription
                showError = true
                print("Transaction error: \(errorMessage)")
            default: break
            }
        }, receiveValue: { value in
            print("Transaction result: \(value)")
            self.result = value as? String ?? ""
        }).store(in: &cancellables)
    }
}

struct Transaction: CodableData {
    let to: String
    let from: String
    let value: String
    let data: String?

    init(to: String, from: String, value: String, data: String? = nil) {
        self.to = to
        self.from = from
        self.value = value
        self.data = data
    }

    func socketRepresentation() -> NetworkData {
        [
            "to": to,
            "from": from,
            "value": value,
            "data": data
        ]
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
