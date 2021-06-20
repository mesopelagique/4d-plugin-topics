//
//  Reporter.swift
//  TopicWorkflowKit
//
//  Created by eric.marchand on 09/01/2020.
//
import FileKit

public protocol Reporter {
    static var identifier: String { get }

    static func generateReport(repositories: [Topic: [Repository]]) -> String
}

public struct Reporters {

    public static func reporter(from reporter: String) -> Reporter.Type {
        switch reporter {
        case DefaultReporter.identifier:
            return DefaultReporter.self
        case MarkdownReporter.identifier:
            return MarkdownReporter.self
        case FileTextReporter.identifier:
            return FileTextReporter.self
        default:
            fatalError("no reporter with identifier '\(reporter) available'")
        }
    }
}
