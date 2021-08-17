//
//  NetworkSessions.swift
//  MyApp
//
//  Created by Vladimir Ratskevich on 17.08.21.
//

import Foundation
import UIKit

class NetworkSessions: ObservableObject {

    public static let shared = NetworkSessions()
    
    func loadExchange(completion: @escaping(Result<ExchangeRatesSum, Never>) -> Void) {
        
        //разбить ссылку на параметры: "r" = "BEYkZbmV" и т.д.
        guard let url = URL(string: "https://alpha.as50464.net:29870/moby-pre-44/core?r=BEYkZbmV&d=563B4852-6D4B-49D6-A86E-B273DD520FD2&t=ExchangeRates&v=44") else {return}
        let parameters = ["uid": "563B4852-6D4B-49D6-A86E-B273DD520FD2", "type": "ExchangeRates", "rid":"BEYkZbmV"]
        
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        request.httpBody = httpBody
        
        request.addValue("Test GeekBrains iOS 3.0.0.182 (iPhone 11; iOS 14.4.1; Scale/2.00; Private)", forHTTPHeaderField: "User-Agent")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
//            if let response = response {
//                print(response)
//            }
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //let json = try JSONSerialization.jsonObject(with: data, options: [])
                let exchangeRatesSum = try JSONDecoder().decode(ExchangeRatesSum.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(exchangeRatesSum))
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
}
