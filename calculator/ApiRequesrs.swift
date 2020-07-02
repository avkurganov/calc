//
//  ApiRequesrs.swift
//  calculator
//
//  Created by Andrey Kurganov on 6/29/20.
//  Copyright © 2020 Andrey Kurganov. All rights reserved.
//

import SwiftUI

class Api {
    
    func getSaleTax(zipCode: Int, completion: @escaping (ResponseSaleTax) -> ()) {

        guard let url = URL(string: "https://sandbox-rest.avatax.com/api/v2/taxrates/bypostalcode?country=US&postalCode=\(zipCode)") else {
           return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Basic YmF0Y2hzdmNAY2xvdWRsZW5kaW5nOiMhMTEwMDExISNSYW0=", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request) { (data, responce, error) in
        let getResponse =  try! JSONDecoder().decode(ResponseSaleTax.self, from: data!)
            
        DispatchQueue.main.async {
                completion(getResponse)
            print(getResponse)
            }
       
        
        }.resume()
        
    }
}

