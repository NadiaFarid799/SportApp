import XCTest
@testable import SportApp

final class FavoritePresenterTests: XCTestCase {

    // MARK: - Mocks

    class MockLocalSource: LocalSource {
        var mockLeagues: [LocalLeague]?
        var didRemoveLeague = false
        var removedLeague: LocalLeague?

        func saveLeague(league: League, sportName: String, image: Data) {}

        func removeLeague(league: LocalLeague) {
            didRemoveLeague = true
            removedLeague = league
        }

        func getLeagues() -> [LocalLeague]? {
            return mockLeagues
        }

        func isLeagueInFavorites(leagueKey: String) -> Bool {
            return false
        }
    }

    class MockFavoriteView: FavoriteViewContract {
        var didUpdateLeagues = false
        var updatedLeagues: [LocalLeague] = []
        var didNavigate = false
        var didFireAlert = false

        func updateLeagues(leagues: [LocalLeague]) {
            didUpdateLeagues = true
            updatedLeagues = leagues
        }

        func naviagateToLeagues() {
            didNavigate = true
        }

        func fireConnectionAlert() {
            didFireAlert = true
        }
    }

    // MARK: - Properties
    var presenter: FavoritePresenter!
    var mockLocalSource: MockLocalSource!
    var mockView: MockFavoriteView!

    override func setUp() {
        super.setUp()
        mockLocalSource = MockLocalSource()
        mockView = MockFavoriteView()
        presenter = FavoritePresenter(localSource: mockLocalSource, favoriteViewContract: mockView)
    }

    // MARK: - Tests

    func testGetLocalLeagues_ShouldUpdateView() {
        // Arrange
        let mockLeague = LocalLeague()
        mockLocalSource.mockLeagues = [mockLeague]

        // Act
        presenter.getLocalLeagues()

        // Assert
        XCTAssertTrue(mockView.didUpdateLeagues)
        XCTAssertEqual(mockView.updatedLeagues.count, 1)
    }

    func testDeleteLeague_ShouldCallRemoveLeague() {
        // Arrange
        let mockLeague = LocalLeague()

        // Act
        presenter.deleteLeague(league: mockLeague)

        // Assert
        XCTAssertTrue(mockLocalSource.didRemoveLeague)
        XCTAssertEqual(mockLocalSource.removedLeague, mockLeague)
    }
}
