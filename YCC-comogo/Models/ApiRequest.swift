//
//  ApiRequest.swift
//  YCC-comogo
//
//  Created by Daniel Lock on 3/25/19.
//  Copyright © 2019 Youth Community Coalition. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET", post = "POST"
}
let base_api_url = "http://157.230.87.126:5050/api/"

class ApiRequest {
    
    func execute(http_method: HTTPMethod, url_path: String, payload: Data) {
        
        guard let url = URL(string: base_api_url + url_path) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = http_method.rawValue
        request.httpBody = payload
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
    }
}
