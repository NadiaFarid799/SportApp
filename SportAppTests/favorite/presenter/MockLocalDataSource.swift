import Foundation
@testable import SportApp

class MockLocalDataSource: LocalSource {

    var mockLeagues: [LocalLeague] = []

    func saveLeague(league: League, sportName: String, image: Data) {
        let localLeague = MockLocalLeague()
        localLeague.mockLeagueKey = Int16(league.league_key)
        localLeague.mockLeagueName = league.league_name
        mockLeagues.append(localLeague)
    }

    func removeLeague(league: LocalLeague) {
        mockLeagues.removeAll { $0.leagueKey == league.leagueKey }
    }

    func getLeagues() -> [LocalLeague]? {
        return mockLeagues
    }

    func isLeagueInFavorites(leagueKey: String) -> Bool {
        guard let key = Int(leagueKey) else { return false }
        return mockLeagues.contains { $0.leagueKey == key }
    }
}


class MockLocalLeague: LocalLeague {
    var mockLeagueKey: Int16 = 0
    var mockLeagueName: String?
    
    override var leagueKey: Int16 {
        get { mockLeagueKey }
        set { mockLeagueKey = newValue }
    }
    
    override var leagueName: String? {
        get { mockLeagueName }
        set { mockLeagueName = newValue }
    }
}
