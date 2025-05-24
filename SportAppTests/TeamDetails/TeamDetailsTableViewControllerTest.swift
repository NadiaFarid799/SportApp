//
//  TeamDetailsTableViewControllerTest.swift
//  SportAppTests
//
//  Created by NadiaFarid on 24/05/2025.
//

import Foundation
import XCTest
@testable import SportApp
import UIKit

final class TeamDetailsTableViewControllerTests: XCTestCase {
    
        var teamTable: TeamDetailsTableViewController!
        
        override func setUp() {
            super.setUp()
            teamTable = TeamDetailsTableViewController()
            
            _ = teamTable.view
            
            let mockPlayers = [
                Players(player_name: "Player One", player_type: "Player", player_image: nil),
                Players(player_name: "Coach Bob", player_type: "Coach", player_image: nil),
                Players(player_name: "Player Two", player_type: "Player", player_image: nil)
            ]
            let team = Team(team_key: 1, team_name: "Mock FC", team_logo: nil, players: mockPlayers)
            
            teamTable.team = team
        }
        
        override func tearDown() {
            teamTable = nil
            super.tearDown()
        }
        
        func testNumberOfSections_isTwo() {
            XCTAssertEqual(teamTable.numberOfSections(in: teamTable.tableView), 2)
        }
        
        func testNumberOfRowsInSection0_isOne() {
            let rows = teamTable.tableView(teamTable.tableView, numberOfRowsInSection: 0)
            XCTAssertEqual(rows, 1)
        }
        
        func testNumberOfRowsInSection1_excludesCoach() {
            let rows = teamTable.tableView(teamTable.tableView, numberOfRowsInSection: 1)
            XCTAssertEqual(rows, 2) // Coach is excluded
        }
        
        func testCellForRowAtSection0_returnsTeamCell() {
            let indexPath = IndexPath(row: 0, section: 0)
            teamTable.tableView.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "teamcell")
            
            let cell = teamTable.tableView(teamTable.tableView, cellForRowAt: indexPath)
            XCTAssertTrue(cell is TeamTableViewCell)
        }
        
        func testCellForRowAtSection1_returnsPlayerCell() {
            let indexPath = IndexPath(row: 0, section: 1)
            teamTable.tableView.register(UINib(nibName: "PlayersTableViewCell", bundle: nil), forCellReuseIdentifier: "playercell")
            
            let cell = teamTable.tableView(teamTable.tableView, cellForRowAt: indexPath)
            XCTAssertTrue(cell is PlayersTableViewCell)
        }}
    
