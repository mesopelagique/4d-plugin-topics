//
//  File.swift
//  
//
//  Created by Eric Marchand on 09/01/2020.
//

import Foundation
import FileKit

public struct Repository: Codable, Hashable, Equatable {
    var full_name: String
    var name: String
    var html_url: String
}

public struct Repositories: Codable {
    var items: [Repository]
    var incomplete_results: Bool
    var total_count: Int
}

extension Repositories: JSONReadableWritable {} // if you want json encoding/decoding

extension Repository {

    var dico: [String: String] {
        return [
            "full_name": full_name,
            "name": name,
            "html_url": html_url
        ]
    }
}


extension Data {

    var repository: Repository? {
        return try? JSONDecoder().decode(Repository.self, from: self)
    }

}
