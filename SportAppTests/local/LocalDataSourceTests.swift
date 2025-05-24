import XCTest
import CoreData
@testable import SportApp

// Mock League model used in tests
//struct League {
//    let league_key: Int
//    let league_name: String
//    let country_name: String
//}

final class LocalDataSourceTests: XCTestCase {

    var context: NSManagedObjectContext!
    var localDataSource: LocalDataSource!
    var entity: NSEntityDescription!

    override func setUpWithError() throws {
        // Arrange: Set up in-memory Core Data stack
        let modelURL = Bundle(for: type(of: self)).url(forResource: "SportApp", withExtension: "momd")!
        let model = NSManagedObjectModel(contentsOf: modelURL)!

        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType,
                                                          configurationName: nil,
                                                          at: nil,
                                                          options: nil)

        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator

        entity = NSEntityDescription.entity(forEntityName: "LocalLeague", in: context)!
        localDataSource = LocalDataSource(entity: entity, context: context)
    }

    override func tearDownWithError() throws {
        context = nil
        localDataSource = nil
        entity = nil
    }

    func testSaveLeague_ShouldAddLeagueToCoreData() throws {
        // Arrange
        let league = League(
            league_key: 1,
            league_name: "Premier League",
            country_key: 100, country_name: "England",
            league_surface: "Grass",
            league_year: "2024",
            league_logo: "logo_url",
            country_logo: "country_logo_url"
        )
        let imageData = Data([0x00, 0x01, 0x02])

        // Act
        localDataSource.saveLeague(league: league, sportName: "Football", image: imageData)

        // Assert
        let fetched = localDataSource.getLeagues()
        XCTAssertEqual(fetched?.count, 1)
        XCTAssertEqual(fetched?.first?.leagueName, "Premier League")
    }

    func testRemoveLeague_ShouldDeleteLeagueFromCoreData() throws {
        // Arrange
        let league = League(
            league_key: 1,
            league_name: "Premier League",
            country_key: 100, country_name: "England",
            league_surface: "Grass",
            league_year: "2024",
            league_logo: "logo_url",
            country_logo: "country_logo_url"
        )
        let imageData = Data([0x00, 0x01, 0x02])
        localDataSource.saveLeague(league: league, sportName: "Football", image: imageData)

        guard let leagueToDelete = localDataSource.getLeagues()?.first else {
            XCTFail("Failed to fetch saved league")
            return
        }

        // Act
        localDataSource.removeLeague(league: leagueToDelete)

        // Assert
        let result = localDataSource.getLeagues()
        XCTAssertEqual(result?.count, 0)
    }

    func testGetLeagues_ShouldReturnSavedLeagues() throws {
        // Arrange
        let laLiga = League(
            league_key: 2,
            league_name: "La Liga",
            country_key: 3, country_name: "Spain",
            league_surface: "Grass",
            league_year: "2024",
            league_logo: "https://example.com/la_liga_logo.png",
            country_logo: "https://example.com/spain_flag.png"
        )
        let imageData = Data([0x03, 0x04, 0x05])
        localDataSource.saveLeague(league: laLiga, sportName: "Football", image: imageData)

        // Act
        let leagues = localDataSource.getLeagues()

        // Assert
        XCTAssertEqual(leagues?.count, 1)
        XCTAssertEqual(leagues?.first?.leagueKey, 2)
    }

    func testIsLeagueInFavorites_ShouldReturnTrueIfExists() throws {
        // Arrange
        let serieA = League(
            league_key: 3,
            league_name: "Serie A",
            country_key: 4, country_name: "Italy",
            league_surface: "Grass",
            league_year: "2024",
            league_logo: "https://example.com/serie_a_logo.png",
            country_logo: "https://example.com/italy_flag.png"
        )
        let imageData = Data([0x06, 0x07, 0x08])
        localDataSource.saveLeague(league: serieA, sportName: "Football", image: imageData)

        // Act
        let exists = localDataSource.isLeagueInFavorites(leagueKey: "3")

        // Assert
        XCTAssertTrue(exists)
    }

    func testIsLeagueInFavorites_ShouldReturnFalseIfNotExists() throws {
        // Act
        let exists = localDataSource.isLeagueInFavorites(leagueKey: "99")

        // Assert
        XCTAssertFalse(exists)
    }

    func testIsLeagueInFavorites_ShouldReturnFalseIfInvalidKey() throws {
        // Act
        let exists = localDataSource.isLeagueInFavorites(leagueKey: "abc")

        // Assert
        XCTAssertFalse(exists)
    }
}
