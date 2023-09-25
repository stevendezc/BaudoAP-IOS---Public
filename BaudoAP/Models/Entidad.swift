//
//  entidades.swift
//  BaudoAP
//
//  Created by Codez Studio on 13/07/23.
//

import Foundation


struct Entidad: Codable {
    let data: [dataEntidad]
    
}

struct dataEntidad: Codable, Hashable {
    let financialInstitutionCode, financialInstitutionName: String
    
    enum CodingKeys: String, CodingKey {
            case financialInstitutionCode = "financial_institution_code"
            case financialInstitutionName = "financial_institution_name"
        }
}


