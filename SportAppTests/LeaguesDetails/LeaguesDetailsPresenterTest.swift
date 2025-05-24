//
//  LeaguesDetailsPresenterTest.swift
//  SportAppTests
//
//  Created by NadiaFarid on 24/05/2025.
//

import Foundation
@testable import SportApp

import XCTest

class LeaguesDetailsPresenterTest : XCTestCase{
    
    
    var presenter: LeaguesDetailsPresenter!
    var mockView: MocaLeaguesDetails!
    var mockService: MockaRemoteServices!
    
    override func setUp() {
        super.setUp()
        mockView = MocaLeaguesDetails()
        mockService = mockView.mockService
        presenter = LeaguesDetailsPresenter(view: mockView , service: mockService)
    }
    
    
    //    override func tearDown() {
    //        mockView = nil
    //        mockService = nil
    //        presenter = nil
    //        super.tearDown()
    //    }
    
    
    
    
    
    func testFetchUpcomingEventsSuccess() {
        // Given
        let event = Event(event_key: 1, event_date: "2025-05-25", event_time: "21:00",
                          event_home_team: "Team A", home_team_key: 1,
                          event_away_team: "Team B", away_team_key: 2,
                          event_halftime_result: "1-0", league_logo: "logo.png",
                          home_team_logo: "home_logo.png", away_team_logo: "away_logo.png",
                          league_key: 100, league_name: "Mock League",
                          event_stadium: "Mock Stadium", league_season: "2024/2025",
                          event_final_result: "2-1")
        mockService.mockUpComingEvet = [event]
        mockService.shouldUpComingEventSucceed = true
        
        // When
        presenter.getUpcomingEvents(leagueId: "123", sportName: "football")
        
        // Then
        XCTAssertTrue(mockView.didUpcomingUpdated)
        XCTAssertEqual(mockView.receivedupComingEvent.count, 1)
        XCTAssertEqual(mockView.receivedupComingEvent.first?.event_home_team, "Team A")
    }
    
    func testFetchUpcomingEventsFailure() {
        // Given
        mockService.shouldUpComingEventSucceed = false
        
        // When
        presenter.getUpcomingEvents(leagueId: "123", sportName: "football")
        
        // Then
        XCTAssertTrue(mockView.didshoeeeror)
        XCTAssertEqual(mockView.receivedupComingEvent.count, 0)
    }
    
    func testFetchLatestEventsSuccess() {
        // Given
        let event = Event(event_key: 1, event_date: "2025-05-25", event_time: "21:00",
                          event_home_team: "Team A", home_team_key: 1,
                          event_away_team: "Team B", away_team_key: 2,
                          event_halftime_result: "1-0", league_logo: "logo.png",
                          home_team_logo: "home_logo.png", away_team_logo: "away_logo.png",
                          league_key: 123, league_name: "Mock League",
                          event_stadium: "Mock Stadium", league_season: "2024/2025",
                          event_final_result: "2-1")
        mockService.mockLatestEvet = [event]
        mockService.shouldLatestEventSucceed = true
        
        // When
        presenter.getLatestEvents(leagueId: "123", sportName: "football")
        
        // Then
        XCTAssertTrue(mockView.didUpLatestUpdated)
        XCTAssertEqual(mockView.receivedLatestEvent.count, 1)
        XCTAssertEqual(mockView.receivedLatestEvent.first?.event_home_team, "Team A")
    }
    
    func testFetchLatestEventsFailure() {
        // Given
        mockService.shouldLatestEventSucceed = false
        
        // When
        presenter.getLatestEvents(leagueId: "123", sportName: "football")
        
        // Then
        XCTAssertTrue(mockView.didshoeeeror)
        XCTAssertEqual(mockView.receivedLatestEvent.count, 0)
    }
    
    func testFetchTeamsSuccess() {
        // Given
        let team = Team(team_key: 1, team_name: "Team Z", team_logo: "")
        mockService.mockTeam = [team]
        mockService.shouldTeamSucceed = true
        
        // When
        presenter.getTeams(leagueId: "123", sportName: "football")
        
        // Then
        XCTAssertTrue(mockView.didTeamsUpdated)
        XCTAssertEqual(mockView.receivedTeams.count, 1)
        XCTAssertEqual(mockView.receivedTeams.first?.team_name, "Team Z")
    }
    
    func testFetchTeamsFailure() {
        // Given
        mockService.shouldTeamSucceed = false
        
        // When
        presenter.getTeams(leagueId: "123", sportName: "football")
        
        // Then
        XCTAssertTrue(mockView.didshoeeeror)
        XCTAssertEqual(mockView.receivedTeams.count, 0)
    }
}
