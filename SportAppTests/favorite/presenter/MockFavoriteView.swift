import Foundation
@testable import SportApp

class MockFavoriteView: FavoriteViewContract {

    var didUpdateLeagues = false
    var didFireConnectionAlert = false
    var didNavigateToLeagues = false
    var receivedLeagues: [LocalLeague]?

    func updateLeagues(leagues: [LocalLeague]) {
        didUpdateLeagues = true
        receivedLeagues = leagues
    }

    func fireConnectionAlert() {
        didFireConnectionAlert = true
    }

    func naviagateToLeagues() {
        didNavigateToLeagues = true
    }
}
