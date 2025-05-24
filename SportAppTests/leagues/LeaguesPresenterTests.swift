//
//  LeaguesPresenterTests.swift
//  SportAppTests
//
//  Created by Macos on 24/05/2025.
//

import XCTest
@testable import SportApp

final class LeaguesPresenterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Properties
        var presenter: LeaguesPresenter!
        var mockView: MockLeagueView!
        var mockRemote: MockRemoteService!
        var mockLocal: MockLocalSource!

        override func setUp() {
            super.setUp()
            mockView = MockLeagueView()
            mockRemote = MockRemoteService()
            mockLocal = MockLocalSource()
            presenter = LeaguesPresenter(leagueViewContract: mockView, remoteService: mockRemote, localSource: mockLocal)
        }

        // MARK: - Tests

        func testGetLeagues_ShouldCallUpdateLeaguesOnSuccess() {
            // Arrange
            let league = League(
                league_key: 1,
                league_name: "Premier League",
                country_key: 100,
                country_name: "England",
                league_surface: "Grass",
                league_year: "2024",
                league_logo: "logo_url",
                country_logo: "country_logo_url"
            )
            mockRemote.mockLeagues = [league]

            // Act
            presenter.getLeagues(sportName: "Football")

            // Assert
            XCTAssertTrue(mockView.didUpdateLeagues)
            XCTAssertEqual(mockView.receivedLeagues.count, 1)
            XCTAssertEqual(mockView.receivedLeagues.first?.league_name, "Premier League")
        }

        func testGetLeagues_ShouldNotUpdateLeaguesOnFailure() {
            // Arrange
            mockRemote.shouldSucceed = false

            // Act
            presenter.getLeagues(sportName: "Football")

            // Assert
            XCTAssertFalse(mockView.didUpdateLeagues)
        }

        func testSaveLeague_ShouldCallLocalSourceSaveLeague() {
            // Arrange
            let league = League(
                league_key: 2,
                league_name: "La Liga",
                country_key: 101,
                country_name: "Spain",
                league_surface: "Grass",
                league_year: "2024",
                league_logo: "logo_url",
                country_logo: "country_logo_url"
            )
            let imageData = Data([0x01, 0x02, 0x03])

            // Act
            presenter.saveLeague(league: league, sportName: "Football", image: imageData)

            // Assert
            XCTAssertEqual(mockLocal.savedLeague?.league_name, "La Liga")
            XCTAssertEqual(mockLocal.savedSportName, "Football")
            XCTAssertEqual(mockLocal.savedImage, imageData)
        }

}
