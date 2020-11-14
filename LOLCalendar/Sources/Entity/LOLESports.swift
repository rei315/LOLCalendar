////
////  LOLESports.swift
////  LOLCalendar
////
////  Created by 김민국 on 2020/11/04.
////
//
//
//import Foundation
//
//// MARK: - LOLESport
//struct LOLESport: Codable {
//    let streams: Streams
//    let slug: String
//    let tournament: Tournament
//    let endAt: Date
//    let status: Status
//    let league: League
//    let originalScheduledAt: Date
//    let live: Live
//    let beginAt: Date
//    let detailedStats: Bool
//    let videogameVersion: VideogameVersion
//    let scheduledAt: Date
//    let name: String
//    let draw: Bool
//    let winner: OpponentClass
//    let officialStreamURL: String
//    let games: [Game]
//    let tournamentID: Int
//    let forfeit: Bool
//    let videogame: Videogame
//    let matchType: MatchType
//    let results: [ESportResult]
//    let serieID, leagueID: Int
//    let opponents: [Opponent]
//    let numberOfGames: Int
//    let modifiedAt: Date
//    let gameAdvantage: JSONNull?
//    let liveEmbedURL: String
//    let winnerID: Int
//    let rescheduled: Bool
//    let id: Int
//    let serie: Serie
//    let liveURL: String
//
//    enum CodingKeys: String, CodingKey {
//        case streams, slug, tournament
//        case endAt = "end_at"
//        case status, league
//        case originalScheduledAt = "original_scheduled_at"
//        case live
//        case beginAt = "begin_at"
//        case detailedStats = "detailed_stats"
//        case videogameVersion = "videogame_version"
//        case scheduledAt = "scheduled_at"
//        case name, draw, winner
//        case officialStreamURL = "official_stream_url"
//        case games
//        case tournamentID = "tournament_id"
//        case forfeit, videogame
//        case matchType = "match_type"
//        case results
//        case serieID = "serie_id"
//        case leagueID = "league_id"
//        case opponents
//        case numberOfGames = "number_of_games"
//        case modifiedAt = "modified_at"
//        case gameAdvantage = "game_advantage"
//        case liveEmbedURL = "live_embed_url"
//        case winnerID = "winner_id"
//        case rescheduled, id, serie
//        case liveURL = "live_url"
//    }
//}
//
//// MARK: - Game
//struct Game: Codable {
//    let beginAt: Date
//    let complete, detailedStats: Bool
//    let endAt: Date
//    let finished, forfeit: Bool
//    let id, length, matchID, position: Int
//    let status: Status
//    let videoURL: JSONNull?
//    let winner: GameWinner
//    let winnerType: WinnerTypeEnum
//
//    enum CodingKeys: String, CodingKey {
//        case beginAt = "begin_at"
//        case complete
//        case detailedStats = "detailed_stats"
//        case endAt = "end_at"
//        case finished, forfeit, id, length
//        case matchID = "match_id"
//        case position, status
//        case videoURL = "video_url"
//        case winner
//        case winnerType = "winner_type"
//    }
//}
//
//// MARK: - GameWinner
//struct GameWinner: Codable {
//    let id: Int
//    let type: WinnerTypeEnum
//}
//
//enum WinnerTypeEnum: String, Codable {
//    case team = "Team"
//}
//
//// MARK: - League
//struct League: Codable {
//    let id: Int
//    let imageURL: String
//    let modifiedAt: Date
//    let name: LeagueName
//    let slug: LeagueSlug
//    let url: JSONNull?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case imageURL = "image_url"
//        case modifiedAt = "modified_at"
//        case name, slug, url
//    }
//}
//
//enum LeagueName: String, Codable {
//    case lck = "LCK"
//}
//
//enum LeagueSlug: String, Codable {
//    case leagueOfLegendsLckChampionsKorea = "league-of-legends-lck-champions-korea"
//}
//
//// MARK: - Live
//struct Live: Codable {
//    let opensAt: Date
//    let supported: Bool
//    let url: String
//
//    enum CodingKeys: String, CodingKey {
//        case opensAt = "opens_at"
//        case supported, url
//    }
//}
//
//enum MatchType: String, Codable {
//    case bestOf = "best_of"
//}
//
//// MARK: - Opponent
//struct Opponent: Codable {
//    let opponent: OpponentClass
//    let type: WinnerTypeEnum
//}
//
//// MARK: - OpponentClass
//struct OpponentClass: Codable {
//    let acronym: Acronym
//    let id: Int
//    let imageURL: String
//    let location: Location
//    let modifiedAt: Date
//    let name: WinnerName
//    let slug: WinnerSlug
//
//    enum CodingKeys: String, CodingKey {
//        case acronym, id
//        case imageURL = "image_url"
//        case location
//        case modifiedAt = "modified_at"
//        case name, slug
//    }
//}
//
//enum Acronym: String, Codable {
//    case af = "AF"
//    case drx = "DRX"
//    case dwg = "DWG"
//    case dyn = "DYN"
//    case gen = "GEN"
//    case hle = "HLE"
//    case kt = "KT"
//    case sb = "SB"
//    case sp = "SP"
//    case t1 = "T1"
//}
//
//enum Location: String, Codable {
//    case kr = "KR"
//}
//
//enum WinnerName: String, Codable {
//    case afreecaFreecs = "Afreeca Freecs"
//    case damwonGaming = "DAMWON Gaming"
//    case drx = "DRX"
//    case genG = "Gen.G"
//    case hanwhaLifeEsports = "Hanwha Life Esports"
//    case ktRolster = "KT Rolster"
//    case sandboxGaming = "SANDBOX Gaming"
//    case seolHaeOnePrince = "SeolHaeOne Prince"
//    case t1 = "T1"
//    case teamDynamics = "Team Dynamics"
//}
//
//enum WinnerSlug: String, Codable {
//    case afreecaFreecs = "afreeca-freecs"
//    case apk = "apk"
//    case damwonGaming = "damwon-gaming"
//    case dragonx = "dragonx"
//    case geng = "geng"
//    case hanwhaLifeEsports = "hanwha-life-esports"
//    case ktRolster = "kt-rolster"
//    case sandboxGaming = "sandbox-gaming"
//    case t1 = "t1"
//    case teamDynamics = "team-dynamics"
//}
//
//// MARK: - Result
//struct ESportResult: Codable {
//    let score, teamID: Int
//
//    enum CodingKeys: String, CodingKey {
//        case score
//        case teamID = "team_id"
//    }
//}
//
//// MARK: - Serie
//struct Serie: Codable {
//    let beginAt: Date
//    let serieDescription: JSONNull?
//    let endAt: Date
//    let fullName: FullName
//    let id, leagueID: Int
//    let modifiedAt: Date
//    let name: JSONNull?
//    let season: Season
//    let slug: SerieSlug
//    let tier: Tier
//    let winnerID, winnerType: JSONNull?
//    let year: Int
//
//    enum CodingKeys: String, CodingKey {
//        case beginAt = "begin_at"
//        case serieDescription = "description"
//        case endAt = "end_at"
//        case fullName = "full_name"
//        case id
//        case leagueID = "league_id"
//        case modifiedAt = "modified_at"
//        case name, season, slug, tier
//        case winnerID = "winner_id"
//        case winnerType = "winner_type"
//        case year
//    }
//}
//
//enum FullName: String, Codable {
//    case summer2020 = "Summer 2020"
//}
//
//enum Season: String, Codable {
//    case summer = "Summer"
//}
//
//enum SerieSlug: String, Codable {
//    case leagueOfLegendsLckChampionsKoreaSummer2020 = "league-of-legends-lck-champions-korea-summer-2020"
//}
//
//enum Tier: String, Codable {
//    case s = "s"
//}
//
//// MARK: - Streams
//struct Streams: Codable {
//    let english, russian: English
//}
//
//// MARK: - English
//struct English: Codable {
//    let embedURL, rawURL: String?
//
//    enum CodingKeys: String, CodingKey {
//        case embedURL = "embed_url"
//        case rawURL = "raw_url"
//    }
//}
//
//// MARK: - Tournament
//struct Tournament: Codable {
//    let beginAt: Date
//    let endAt: Date?
//    let id, leagueID: Int
//    let liveSupported: Bool
//    let modifiedAt: Date
//    let name: TournamentName
//    let prizepool: String?
//    let serieID: Int
//    let slug: String
//    let winnerID: Int?
//    let winnerType: WinnerTypeEnum
//
//    enum CodingKeys: String, CodingKey {
//        case beginAt = "begin_at"
//        case endAt = "end_at"
//        case id
//        case leagueID = "league_id"
//        case liveSupported = "live_supported"
//        case modifiedAt = "modified_at"
//        case name, prizepool
//        case serieID = "serie_id"
//        case slug
//        case winnerID = "winner_id"
//        case winnerType = "winner_type"
//    }
//}
//
//enum TournamentName: String, Codable {
//    case playoffs = "Playoffs"
//    case regionalFinals = "Regional finals"
//    case regularSeason = "Regular season"
//}
//
//// MARK: - Videogame
//struct Videogame: Codable {
//    let id: Int
//    let name: VideogameName
//    let slug: VideogameSlug
//}
//
//enum VideogameName: String, Codable {
//    case loL = "LoL"
//}
//
//enum VideogameSlug: String, Codable {
//    case leagueOfLegends = "league-of-legends"
//}
//
//// MARK: - VideogameVersion
//struct VideogameVersion: Codable {
//    let current: Bool
//    let name: VideogameVersionName
//}
//
//enum VideogameVersionName: String, Codable {
//    case the10131 = "10.13.1"
//    case the10141 = "10.14.1"
//    case the10151 = "10.15.1"
//    case the10161 = "10.16.1"
//}
//
//typealias LOLESports = [LOLESport]
