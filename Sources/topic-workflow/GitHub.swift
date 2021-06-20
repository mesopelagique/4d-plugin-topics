//
//  GitHub.swift
//  
//
//  Created by Eric Marchand on 20/06/2021.
//

import Foundation


struct GitHub {
    
    let token: String
   
    func repositories(for topic: Topic) -> [Repository] {
        let data = query(address: "https://api.github.com/search/repositories?q=topic:\(topic)")
        return (try? JSONDecoder().decode(Repositories.self, from: data).items) ?? [] // fail silently (could add log)
        // mock:
        /*if topic == "4d-plugin" {
            return [Repository(full_name: "test", name: "test", html_url: "http://test"),
                    Repository(full_name: "noyym1", name: "noyym1", html_url: "http://noyym1")]
        }
        return [Repository(full_name: "test", name: "test", html_url: "http://test")]*/
    }
    
    func query(address: String) -> Data { // one day use async await :)
        let url = URL(string: address)!
        let semaphore = DispatchSemaphore(value: 0)

        var result: Data = Data()
        
        var request: URLRequest = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "Accept": "application/vnd.github.mercy-preview+json",
            "Authorization": "token \(token)"
        ]
        URLSession.shared.dataTask(with: request)
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let data = data {
                result = data
            } else if let error = error {
                print("\(error)")
            }
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        return result
    }

}
