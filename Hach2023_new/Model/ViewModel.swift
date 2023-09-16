//
//  ViewModel.swift
//  Hach2023_new
//
//  Created by Dosi Dimitrov on 16.09.23.
//

import Foundation
class Arad: ObservableObject {
    
    @Published var mataMaskID : String = ""
    @Published var name       : [String] = []
    @Published var infoRichemont : Richemont?
    
  
    func readHashFromCasper() async {
        let url = URL(string: "https://testnet.cspr.live/contract-package/0256c9e16b4d04baf08d0691a35effb823c92d644ed3a2bb8a866567a0f856cb")!
        let urlSession = URLSession.shared

        do {
            let (data, response) = try await urlSession.data(from: url)
            let contract = Contract(data: data)
            self.infoRichemont =  await contract.queryContractDictionary("watches","1")
            print(response)
        }
        catch {
            // Error handling in case the data couldn't be loaded
            // For now, only display the error on the console
            debugPrint("Error loading \(url): \(String(describing: error))")
        }
      //  const Ivan_hash = await contract.queryContractDictionary(
      //          "watches",
      //          "1"
      //  )
    }
    func readHashFromHedera() async {
        let url = URL(string: "https://hashscan.io/testnet/contract/0.0.2005189?p=1&k=1694849115.988695003")!
        let urlSession = URLSession.shared

        do {
            let (data, response) = try await urlSession.data(from: url)
            let contract = Contract(data: data)
            self.infoRichemont =  await contract.queryContractDictionary("watches","1")
            print(response)
        }
        catch {
            // Error handling in case the data couldn't be loaded
            // For now, only display the error on the console
            debugPrint("Error loading \(url): \(String(describing: error))")
        }

    }
}
