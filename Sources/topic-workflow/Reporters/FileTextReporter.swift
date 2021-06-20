//
//  File.swift
//  
//

import Foundation
import FileKit

struct FileTextReporter: Reporter {

    static let identifier = "filetext"

    static func generateReport(repositories: [Topic: [Repository]]) -> String {
        var output = ""
        for (topic, repositories) in repositories {
            var string = ""
            for item in repositories.sorted(by: { $0.full_name < $1.full_name }) {
                string += "\(item.html_url)\n"
            }
            let path = Path.current + "\(topic).txt"
            try? TextFile(path: path).write(string)
            output += "\(path.rawValue)\n"
        }
        return ""
    }
}
