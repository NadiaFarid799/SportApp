//
//  MockaRemoteServices.swift
//  SportAppTests
//
//  Created by NadiaFarid on 24/05/2025.
//

import Foundation
@testable import SportApp

class MockaRemoteServices : LeagueService {
    
    
    var preparedUpComingEventURL: URL = URL(string: "https://mock-url.com")!
    var shouldUpComingEventSucceed = true
    var mockUpComingEvet: [Event] = []
    
    var preparedLatestEventURL: URL = URL(string: "https://mock-url.com")!
    var shouldLatestEventSucceed = true
    var mockLatestEvet: [Event] = []
    
    
    var preparedTeamURL: URL = URL(string: "https://mock-url.com")!
    var shouldTeamSucceed = true
    var mockTeam: [Team] = []
    
    
    
    override func prepareUpcomingEventsURL(leagueId: String, sportName: String) -> URL {
        return preparedUpComingEventURL
    }
    
    override func fetchUpcomingEvents(leagueId: String, sportName: String, completion: @escaping (Result<[Event], Error>) -> Void) {
        if shouldUpComingEventSucceed{
            completion(.success((mockUpComingEvet)))
        }else {
            completion(.failure(NSError(domain: "MockaError", code: 1,userInfo: [NSLocalizedDescriptionKey:"UPcomming events fetch faild"])))
        }
    }
    
    
    override func prepareLatestEventsURL(leagueId: String, sportName: String) -> URL {
        return preparedLatestEventURL
    }
    
    override func fetchLatestEvents(leagueId: String, sportName: String, completion: @escaping (Result<[Event], Error>) -> Void) {
        if shouldLatestEventSucceed{
            completion(.success((mockLatestEvet)))
        }else {
            completion(.failure(NSError(domain: "MockaError", code: 1,userInfo: [NSLocalizedDescriptionKey:"latest events fetch faild"])))
        }
    }
    
    override func prepareTeamsURL(leagueId: String, sportName: String) -> URL {
        return preparedTeamURL
    }
    override func fetchTeams(leagueId: String, sportName: String, completion: @escaping (Result<[Team], Error>) -> Void) {
        if shouldTeamSucceed{
            completion(.success((mockTeam)))
        }else {
            completion(.failure(NSError(domain: "MockaError", code: 1,userInfo: [NSLocalizedDescriptionKey:" events fetch faild"])))
        }
    }
}
