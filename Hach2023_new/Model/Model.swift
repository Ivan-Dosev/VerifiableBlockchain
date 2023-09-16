//
//  Model.swift
//  Hach2023_new
//
//  Created by Dosi Dimitrov on 15.09.23.
//

import SwiftUI

struct Model : Identifiable, Equatable{
    
    var id = UUID().uuidString
    var nameUniversity : University
    var nameStudent    : [String]
    
  // static func ==(lhs: Model, rhs: Model) -> Bool {
  //     return lhs.nameUniversity.rawValue == rhs.nameUniversity.rawValue
  // }
}

var  modelPreviews : [Model] = [
    Model(nameUniversity: .ETHZurich, nameStudent: ["Maurice Watts", "Lexie Watkins"]),
    Model(nameUniversity: .TU_Munchen, nameStudent: ["Felix Dickson", "Briar Weaver", "Jax Malone"]),
    Model(nameUniversity: .Oxford , nameStudent: ["Armando Leonard"]),
    Model(nameUniversity: .Harvard, nameStudent: ["Keily Pittman"]),
    Model(nameUniversity: .Stanford, nameStudent: ["Karter Malone"]),
    Model(nameUniversity: .RWTH_Aachen, nameStudent: ["Finnley Richard"]),
    Model(nameUniversity: .Kings_college, nameStudent: ["Callum Bowen"]),
  
]
enum University : String , CaseIterable, Equatable{
    
        case ETHZurich      = "ETH Zurich"
        case TU_Munchen     = "TU Munchen"
        case Oxford         = "Oxford"
        case Harvard        = "Harvard"
        case Stanford       = "Stanford"
        case RWTH_Aachen    = "RWTH Aachen"
        case Kings_college  = "King's college"
    
    
    
    func mimi() -> [String] {
        switch self {
        case .ETHZurich: return ["Maurice Watts", "Lexie Watkins"]
        case .TU_Munchen: return ["Felix Dickson", "Briar Weaver", "Jax Malone"]
        case .Oxford: return ["Armando Leonard"]
        case .Harvard: return ["Keily Pittman"]
        case .Stanford: return ["Karter Malone"]
        case .RWTH_Aachen: return ["Finnley Richard"]
        case .Kings_college: return ["Callum Bowen"]
        }
    }

    
}

extension University {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

struct Richemont : Identifiable, Decodable {
    var id           : Int
    var name         : String
    var producer     : String
    var year         : String
    var seriennnummer: String
    var gehause      : String
    var encryptHASH  : String
    
}

struct Contract {
    var data : Data
    
    func  queryContractDictionary(_ name: String, _ adress: String) -> Richemont{
        return Richemont(id: 202, name: "", producer: "", year: "", seriennnummer: "", gehause: "", encryptHASH: "")
    }
}
