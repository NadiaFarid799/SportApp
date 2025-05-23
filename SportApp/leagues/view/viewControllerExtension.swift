//
//  viewControllerExtension.swift
//  SportApp
//
//  Created by Macos on 23/05/2025.
//

import Foundation

extension LeaguesViewController : LeagueCellDelegate{
    
    func onFavoriteClicked(in cell: LeaguesViewCell) {
        guard let indexPath = leaguesTableView.indexPath(for: cell) else { return }
        let league = leagues[indexPath.row]

        // Get the league image as Data
        let image = cell.leagueImage.image?.pngData() ?? Data()

        // Save to CoreData
        leaguesViewPresenter?.saveLeague(league: league, sportName: sportName!, image: image)
    }
    
}
