//
//  DefaultReporter.swift
//  TopicWorkflowKit
//

import Foundation
import FileKit

struct DefaultReporter: Reporter {

    static let identifier = "default"

    static func generateReport(repositories: [Topic: [Repository]]) -> String {
        var string = ""
        for (topic, repositories) in repositories {
            string += "🏷  \(topic)\n"
            for item in repositories {
                string += "📦 \(item.full_name)\n"
            }
            string += "\n"
        }
        return string
    }
}
