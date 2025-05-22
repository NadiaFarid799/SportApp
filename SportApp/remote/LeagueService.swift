//
//  LeagueService.swift
//  SportApp
//
//  Created by Macos on 19/05/2025.
//

import Foundation
import Alamofire

class LeagueService: RemoteService {
    func prepareURL(sportname: String) -> URL {
        let urlString = "https://apiv2.allsportsapi.com/\(sportname.lowercased())/?met=Leagues&APIkey=\(apiKey)"
        return URL(string: urlString)!
    }
    
    
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    func prepareUpcomingEventsURL(leagueId: String,sportName:String) -> URL {
        let today = Date()
        let futureDate = Calendar.current.date(byAdding: .day, value: 7, to: today)!
        let fromDate = dateFormatter.string(from: today)
        let toDate = dateFormatter.string(from: futureDate)
        
        let urlString = "https://apiv2.allsportsapi.com/\(sportName.lowercased())/?met=Fixtures&from=\(fromDate)&to=\(toDate)&leagueId=\(leagueId)&APIkey=\(apiKey)"
        return URL(string: urlString)!
    }
    
    func prepareLatestEventsURL(leagueId: String,sportName:String) -> URL {
        let today = Date()
        let pastDate = Calendar.current.date(byAdding: .day, value: -7, to: today)!
        let fromDate = dateFormatter.string(from: pastDate)
        let toDate = dateFormatter.string(from: today)
        
        let urlString = "https://apiv2.allsportsapi.com/\(sportName.lowercased())/?met=Fixtures&from=\(fromDate)&to=\(toDate)&leagueId=\(leagueId)&APIkey=\(apiKey)"
        return URL(string: urlString)!
    }
    
    func prepareTeamsURL(leagueId: String,sportName:String) -> URL {
        
        
        let urlString = "https://apiv2.allsportsapi.com/\(sportName.lowercased())/?met=Teams&leagueId=\(leagueId)&APIkey=\(apiKey)"
        return URL(string: urlString)!
    }
    
    
    
    func fetchData<T: Codable>(url: URL, completion: @escaping (Result<T,Error>) -> Void) {
        AF.request(url).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let decodedData):
                completion(.success(decodedData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchUpcomingEvents(leagueId: String,sportName:String, completion: @escaping (Result<[Event], Error>) -> Void) {
        let url = prepareUpcomingEventsURL(leagueId: leagueId,sportName: sportName)
        fetchData(url: url) { (result: Result<EventResponse, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.result ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchLatestEvents(leagueId: String,sportName:String, completion: @escaping (Result<[Event], Error>) -> Void) {
        let url = prepareLatestEventsURL(leagueId: leagueId,sportName: sportName)
        fetchData(url: url) { (result: Result<EventResponse, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.result ?? []))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTeams(leagueId: String, sportName:String,completion: @escaping (Result<[Team], Error>) -> Void) {
        let url = prepareTeamsURL(leagueId: leagueId,sportName: sportName)
        fetchData(url: url) { (result: Result<TeamResponse, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.result ?? [] ))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}
