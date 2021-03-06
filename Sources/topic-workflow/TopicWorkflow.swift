import Foundation
import ArgumentParser

var topics: [Topic] = ["4d-plugin", "4d-plugin-apple-silicon"]

struct TopicWorkflow: ParsableCommand {
    
    
    @Option(name: .shortAndLong, help: "the output format reporter")
    var reporter: String?
    
    @Option(name: .shortAndLong, help: "github api key")
    var githubApiKey: String
    
    public func run() throws {
        let github = GitHub(token: githubApiKey)
        let selectedReporter = Reporters.reporter(from: self.reporter ?? DefaultReporter.identifier)
        
        let repositories: [Topic : [Repository]] = Dictionary(try topics.map {
            ($0, try $0.repositories(github: github))
        }) { key, value in return key }
        
        let report = selectedReporter.generateReport(repositories: repositories)
        print(report)
    }
}

public typealias Topic = String
extension Topic {
    
    func repositories(github: GitHub) throws -> [Repository] {
        return try github.repositories(for: self)
    }
}
