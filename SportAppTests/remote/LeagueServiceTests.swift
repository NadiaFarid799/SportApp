//
//  LeagueServiceTests.swift
//  SportAppTests
//
//  Created by Macos on 24/05/2025.
//

import XCTest
import SDWebImage
@testable import SportApp

final class LeagueServiceTests: XCTestCase {

    var leagueService: LeagueService!

    override func setUpWithError() throws {
        leagueService = LeagueService()
    }

    override func tearDownWithError() throws {
        leagueService = nil
    }

    // URL preparation for leagues
    func testPrepareURL() {
        // Arrange
        let sport = "Football"
        
        // Act
        let url = leagueService.prepareURL(sportname: sport)
        
        // Assert
        XCTAssertTrue(url.absoluteString.contains("football"))
        XCTAssertTrue(url.absoluteString.contains("met=Leagues"))
    }

    // Test URL preparation for upcoming events
    func testPrepareUpcomingEventsURL() {
        // Act
        let url = leagueService.prepareUpcomingEventsURL(leagueId: "123", sportName: "Football")
        
        // Assert
        XCTAssertTrue(url.absoluteString.contains("Fixtures"))
        XCTAssertTrue(url.absoluteString.contains("leagueId=123"))
    }

    // Test URL preparation for latest events
    func testPrepareLatestEventsURL() {
        // Act
        let url = leagueService.prepareLatestEventsURL(leagueId: "123", sportName: "Basketball")
        
        // Assert
        XCTAssertTrue(url.absoluteString.contains("Fixtures"))
        XCTAssertTrue(url.absoluteString.contains("leagueId=123"))
    }

    // Test URL preparation for teams
    func testPrepareTeamsURL() {
        // Act
        let url = leagueService.prepareTeamsURL(leagueId: "456", sportName: "Tennis")
        
        // Assert
        XCTAssertTrue(url.absoluteString.contains("Teams"))
        XCTAssertTrue(url.absoluteString.contains("leagueId=456"))
    }

    // Test fetching leagues returns a valid result
    func testFetchLeaguesReturnsSuccess() {
        // Arrange
        let expectation = self.expectation(description: "Fetching leagues")
        let url = leagueService.prepareURL(sportname: "football")
        
        // Act
        leagueService.fetchData(url: url) { (result: Result<LeagueResponse, Error>) in
            // Assert
            switch result {
            case .success(let response):
                XCTAssertNotNil(response.result) // Data must not be nil
            case .failure(let error):
                XCTFail("Expected success but got failure: \(error)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    // Test fetching upcoming events is successful
    func testFetchUpcomingEventsReturnsSuccess() {
        // Arrange
        let expectation = self.expectation(description: "Fetching upcoming events")
        
        // Act
        leagueService.fetchUpcomingEvents(leagueId: "198", sportName: "football") { result in
            // Assert
            switch result {
            case .success(let events):
                XCTAssertNotNil(events)
            case .failure(let error):
                XCTFail("Expected success but got failure: \(error)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    // Test fetching latest events is successful
    func testFetchLatestEventsReturnsSuccess() {
        // Arrange
        let expectation = self.expectation(description: "Fetching latest events")

        // Act
        leagueService.fetchLatestEvents(leagueId: "198", sportName: "football") { result in
            // Assert
            switch result {
            case .success(let events):
                XCTAssertNotNil(events)
            case .failure(let error):
                XCTFail("Expected success but got failure: \(error)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

    // Test fetching teams is successful
    func testFetchTeamsReturnsSuccess() {
        // Arrange
        let expectation = self.expectation(description: "Fetching teams")

        // Act
        leagueService.fetchTeams(leagueId: "198", sportName: "football") { result in
            // Assert
            switch result {
            case .success(let teams):
                XCTAssertNotNil(teams)
            case .failure(let error):
                XCTFail("Expected success but got failure: \(error)")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)
    }

}
