//
//  MockaLeaguesDetailsView.swift
//  SportAppTests
//
//  Created by NadiaFarid on 24/05/2025.
//

import Foundation
@testable import SportApp

class MocaLeaguesDetails : LeagueDetailsViewProtocol{
    
    
    
    var mockService : MockaRemoteServices
    init (){
        self.mockService = MockaRemoteServices()
    }
    var didUpcomingUpdated = false
    
    var receivedupComingEvent: [Event] = []
    
    
    var didUpLatestUpdated = false
    
    var receivedLatestEvent: [Event] = []
    
    
    var didTeamsUpdated = false
    
    var receivedTeams: [Team] = []
    var didshoeeeror = false
    var receivederorrmessage = ""
  
    func showUpcomingEvents(_ events: [SportApp.Event]) {
        didUpcomingUpdated = true
        receivedupComingEvent = events
    }
    
    func showLatestEvents(_ events: [SportApp.Event]) {
        didUpLatestUpdated = true
        receivedLatestEvent = events
    }
    
    func showTeams(_ teams: [SportApp.Team]) {
        didTeamsUpdated = true
        receivedTeams = teams
    }
    
    func showError(_ error: String) {
        didshoeeeror = true
        receivederorrmessage = error
    }
    
    
    
    
    
    
    
   
    
}

