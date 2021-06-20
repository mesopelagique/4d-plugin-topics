//
//  TopicWorkflowKit
//
//  Created by eric.marchand on 09/01/2020.
//

import Foundation
import FileKit

struct MarkdownReporter: Reporter {

    static let identifier = "markdown"
    
    static func generateReport(repositories: [Topic: [Repository]]) -> String {
        var string = ""
        // table header with topics
        string += "| Name | \(topics.joined(separator: " | ")) |\n"
        string += "| - \( String(repeating:  " | -", count: topics.count)) |\n"
        
        let allRepo = Set(repositories.values.flatMap { $0 }).sorted(by: { $0.full_name < $1.full_name})
        
        for item in allRepo {
            string += "|[\(item.full_name)](\(item.html_url)) |"
            
            for topic in topics {
                string += (repositories[topic]!.contains(item)) ? "✅" : "❌"
                string += " |"
            }
            string += "\n"
        }

        return string
    }
}
