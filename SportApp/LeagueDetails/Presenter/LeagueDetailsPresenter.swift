//
//  LeagueDetailsPresenter.swift
//  SportApp
//
//  Created by NadiaFarid on 17/05/2025.
//
//
//import Foundation
//
//class LeagueDetailsPresenter {
//
//    weak var view: LeagueDetailsViewProtocol?
//    let apiKey = "67b9bf30f793d80b7fbe6a17e67804332ea9f0399c9d9f66ae7da6aa2cb9f346"
//
//    init(view: LeagueDetailsViewProtocol) {
//        self.view = view
//    }
//
//    func getLeagueDetails(leagueId: String) {
//        fetchEvents(type: "Fixtures", leagueId: leagueId) { [weak self] events in
//            self?.view?.showUpcomingEvents(events)
//        }
//
//        fetchEvents(type: "Livescore", leagueId: leagueId) { [weak self] events in
//            self?.view?.showLatestEvents(events)
//        }
//
//        fetchTeams(leagueId: leagueId) { [weak self] teams in
//            self?.view?.showTeams(teams)
//        }
//    }
//
//    private func fetchEvents(type: String, leagueId: String, completion: @escaping ([Event]) -> Void) {
//        let urlStr = "https://apiv2.allsportsapi.com/football/?met=\(type)&leagueId=\(leagueId)&APIkey=\(apiKey)"
//        guard let url = URL(string: urlStr) else {
//            self.view?.showError("Invalid URL for events")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data else {
//                self.view?.showError("Failed to load events: \(error?.localizedDescription ?? "Unknown error")")
//                print("No data received")
//
//                return
//            }
//
//            do {
//                let response = try JSONDecoder().decode(EventResponse.self, from: data)
//                print(" Events fetched: \(response.result.count)")
//
//                completion(response.result)
//
//            } catch {
//                self.view?.showError("Failed to parse events")
//            }
//        }.resume()
//    }
//
//    private func fetchTeams(leagueId: String, completion: @escaping ([Team]) -> Void) {
//        let urlStr = "https://apiv2.allsportsapi.com/football/?met=Teams&leagueId=\(leagueId)&APIkey=\(apiKey)"
//        guard let url = URL(string: urlStr) else {
//            self.view?.showError("Invalid URL for teams")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data else {
//                self.view?.showError("Failed to load teams: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//
//            do {
//                let response = try JSONDecoder().decode(TeamResponse.self, from: data)
//                print(" Events fetched: \(response.result.count)")
//
//
//                completion(response.result)
//            } catch {
//                self.view?.showError("Failed to parse teams")
//            }
//        }.resume()
//    }
//}

/// alamofire
///
///
///
import Foundation
import Alamofire


class LeaguePresenter: LeaguePresenterProtocol {
    
    private let leagueService: LeagueService
    private weak var view: LeagueDetailsViewProtocol?
    
    init(view: LeagueDetailsViewProtocol, service: LeagueService = LeagueService()) {
        self.view = view
        self.leagueService = service
    }
    
    func getUpcomingEvents(leagueId: String) {
        leagueService.fetchUpcomingEvents(leagueId: leagueId) { [weak self] result in
            switch result {
            case .success(let events):
                self?.view?.showUpcomingEvents(events)
                print("up\(events)")

            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
        }
    }
    
    func getLatestEvents(leagueId: String) {
        leagueService.fetchLatestEvents(leagueId: leagueId) { [weak self] result in
            switch result {
            case .success(let events):
                self?.view?.showLatestEvents(events)
                print("latetet\(events)")
            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
        }
    }
    
    func getTeams(leagueId: String) {
        leagueService.fetchTeams(leagueId: leagueId) { [weak self] result in
            switch result {
            case .success(let teams):
                self?.view?.showTeams(teams)
                print("teams\(teams)")

            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
        }
    }
}


//
//protocol LeagueViewProtocol: AnyObject {
//    func showUpcomingEvents(_ events: [Event])
//    func showLatestEvents(_ events: [Event])
//    func showTeams(_ teams: [Team])
//    func showError(_ error: Error)
//}


//class LeagueDetailsPresenter {
//
//    weak var view: LeagueDetailsViewProtocol?
//    let service = LeagueService()
//    let apiKey = "67b9bf30f793d80b7fbe6a17e67804332ea9f0399c9d9f66ae7da6aa2cb9f346"
//
//    init(view: LeagueDetailsViewProtocol) {
//        self.view = view
//    }
//
//
//    // this method of service
//            func getLeagueDetails(leagueId: String) {
//                service.fetchUpcomingEvents(leagueId: leagueId) { [weak self] result in
//                    switch result {
//                    case .success(let events):
//                        self?.view?.showUpcomingEvents(events)
//                        print("coming\(events)")
//
//                    case .failure(let error):
//                        self?.view?.showError("Failed to fetch upcoming events: \(error.localizedDescription)")
//                    }
//                }
//
//                service.fetchLatestEvents(leagueId: leagueId) { [weak self] result in
//                    switch result {
//                    case .success(let events):
//                        self?.view?.showLatestEvents(events)
//                        print("latest\(events)")
//                    case .failure(let error):
//                        self?.view?.showError("Failed to fetch latest events: \(error.localizedDescription)")
//                    }
//                }
//            }
//
//
//
//        }
    
    
//    func getLeagueDetails(leagueId: String) {
//        fetchEvents(type: "Fixtures", leagueId: leagueId) { [weak self] events in
//            self?.view?.showUpcomingEvents(events)
//        }
//
//        fetchEvents(type: "Livescore", leagueId: leagueId) { [weak self] events in
//            self?.view?.showLatestEvents(events)
//        }
//
//        fetchTeams(leagueId: leagueId) { [weak self] teams in
//            self?.view?.showTeams(teams)
//        }
//    }
//
//    private func fetchEvents(type: String, leagueId: String, completion: @escaping ([Event]) -> Void) {
//        let url = "https://apiv2.allsportsapi.com/basketball/"
//        let parameters: [String: Any] = [
//            "met": "Fixtures",
//            "leagueId": leagueId,
//            "APIkey": apiKey
//        ]
//
//        AF.request(url, parameters: parameters)
//            .validate()
//            .responseDecodable(of: EventResponse.self) { response in
//                switch response.result {
//                case .success(let eventResponse):
////                    print("Events fetched: \(eventResponse.result.count?? [])")
//                    print("Events fetched: \(eventResponse.result)")
//
//                    completion(eventResponse.result ?? [])
//                case .failure(let error):
//                    self.view?.showError("Failed to load events: \(error.localizedDescription)")
//                }
//            }
//    }
//
//
//
//
//    private func fetchTeams(leagueId: String, completion: @escaping ([Team]) -> Void) {
//        let url = "https://apiv2.allsportsapi.com/football/"
//        let parameters: [String: Any] = [
//            "met": "Teams",
//            "leagueId": leagueId,
//            "APIkey": apiKey
//        ]
//
//        AF.request(url, parameters: parameters)
//            .validate()
//            .responseDecodable(of: TeamResponse.self) { response in
//                switch response.result {
//                case .success(let teamResponse):
//                    print(" Teams fetched: \(teamResponse.result.count)")
//                    print("teams fetched: \(teamResponse.result)")
//                    completion(teamResponse.result)
//                case .failure(let error):
//                    self.view?.showError("Failed to load teams: \(error.localizedDescription)")
//                }
//            }
//    }
//
//}






























//    private func fetchLatestEvents(type: String, leagueId: String, completion: @escaping ([Event]) -> Void) {
//        let url = "https://apiv2.allsportsapi.com/basketball/&from=2018-05-23&to=2018-05-23"
//        let parameters: [String: Any] = [
//            "met": "Fixtures",
//            "leagueId": leagueId,
//            "APIkey": apiKey,
//
//
//        ]
//
//        AF.request(url,parameters: parameters)
//            .validate()
//            .responseDecodable(of: EventResponse.self) { response in
//                switch response.result {
//                case .success(let eventResponse):
//                    print("Events fetched: \(eventResponse.result.count)")
//                    completion(eventResponse.result)
//                case .failure(let error):
//                    self.view?.showError("Failed to load events: \(error.localizedDescription)")
//                }
//            }
//    }
//    func fetchLatestEvents(leagueId: Int, completion: @escaping ([Event]) -> Void) {
//        let url = "https://apiv2.allsportsapi.com/football/"
//        let parameters: [String: Any] = [
//            "met": "Livescore",
//            "leagueId": leagueId,
//            "APIkey": "your_api_key_here"
//        ]
//
//        AF.request(url, method: .get, parameters: parameters)
//            .validate()
//            .responseDecodable(of: EventResponse.self) { response in
//                switch response.result {
//                case .success(let data):
//                    print("Latest Events fetched: \(data.result.count)")
//                    completion(data.result)
//                case .failure(let error):
//                    print("Failed to fetch latest events: \(error.localizedDescription)")
//                    completion([])
//                }
//            }
//    }
//
//    func fetchUpcomingEvents(leagueId: Int, completion: @escaping ([Event]) -> Void) {
//        let url = "https://apiv2.allsportsapi.com/football/"
//        let parameters: [String: Any] = [
//            "met": "Fixtures",
//            "leagueId": leagueId,
//            "APIkey": "your_api_key_here"
//        ]
//
//        AF.request(url, method: .get, parameters: parameters)
//            .validate()
//            .responseDecodable(of: EventResponse.self) { response in
//                switch response.result {
//                case .success(let data):
//                    print("Upcoming Events fetched: \(data.result.count)")
//                    completion(data.result)
//                case .failure(let error):
//                    print("Failed to fetch upcoming events: \(error.localizedDescription)")
//                    completion([])
//                }
//            }
//    }
//
//
