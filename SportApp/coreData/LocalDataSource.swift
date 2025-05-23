//
//  LocalDataSource.swift
//  SportApp
//
//  Created by Macos on 23/05/2025.
//

import Foundation
import CoreData

class LocalDataSource : LocalSource{
    
    var entity: NSEntityDescription
    var context: NSManagedObjectContext
    
    init(entity: NSEntityDescription, context: NSManagedObjectContext) {
        self.entity = entity
        self.context = context
    }
    
    func saveLeague(league: League, sportName: String, image: Data) {
        
        print("execution reached to local data source ")
        
        let leagueObj = NSManagedObject(entity: self.entity, insertInto: self.context)
        
        leagueObj.setValue(league.country_name, forKey: "countryName")
        leagueObj.setValue(image, forKey: "leagueImage")
        leagueObj.setValue(league.league_key, forKey: "leagueKey")
        leagueObj.setValue(league.league_name, forKey: "leagueName")
        leagueObj.setValue(sportName, forKey: "sportName")
        
        do{
            try context.save()
            print("Added Successfully")
        } catch let error{
            print(error)
        }
    }
    
    func removeLeague(league: LocalLeague) {
        context.delete(league)
            
        do {
            try context.save()
        } catch {
            print("Failed to delete league: \(error)")
        }
    }
    
    func getLeagues() -> [LocalLeague]? {
        var localLeagues: [LocalLeague]? = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:"LocalLeague")
        
        do{
            localLeagues = try context.fetch(fetchRequest) as? [LocalLeague]
        } catch let error{
            print(error)
        }
        
        return localLeagues
    }
    
    func isLeagueInFavorites(leagueKey: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LocalLeague")
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", leagueKey)
        fetchRequest.fetchLimit = 1
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Failed to check if league is favorited: \(error)")
            return false
        }
    }
    
}
