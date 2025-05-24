//
//  MockLeagueView.swift
//  SportAppTests
//
//  Created by Macos on 24/05/2025.
//

import Foundation
@testable import SportApp

class MockLeagueView: LeagueViewContract {
    var didUpdateLeagues = false
    var receivedLeagues: [League] = []

    func updateLeagues(leagues: [League]) {
        didUpdateLeagues = true
        receivedLeagues = leagues
    }
}
