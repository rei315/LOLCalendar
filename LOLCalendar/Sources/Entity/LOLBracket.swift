//
//import Foundation
//
//// MARK: - LOLBracketElement
//struct LOLBracketElement: Codable {
//    let beginAt: Date
//    let detailedStats, draw: Bool
//    let endAt: Date
//    let forfeit: Bool
//    let gameAdvantage: JSONNull?
//    let games: [BracketGame]
//    let id: Int
//    let live: BracketLive
//    let liveEmbedURL, liveURL: String
//    let matchType: BracketMatchType
//    let modifiedAt: Date
//    let name: String
//    let numberOfGames: Int
//    let officialStreamURL: String
//    let opponents: [OpponentElement]
//    let originalScheduledAt: Date
//    let previousMatches: [PreviousMatch]
//    let scheduledAt: Date
//    let slug: String
//    let status: Status
//    let streams: BracketStreams
//    let tournamentID, winnerID: Int
//
//    enum CodingKeys: String, CodingKey {
//        case beginAt = "begin_at"
//        case detailedStats = "detailed_stats"
//        case draw
//        case endAt = "end_at"
//        case forfeit
//        case gameAdvantage = "game_advantage"
//        case games, id, live
//        case liveEmbedURL = "live_embed_url"
//        case liveURL = "live_url"
//        case matchType = "match_type"
//        case modifiedAt = "modified_at"
//        case name
//        case numberOfGames = "number_of_games"
//        case officialStreamURL = "official_stream_url"
//        case opponents
//        case originalScheduledAt = "original_scheduled_at"
//        case previousMatches = "previous_matches"
//        case scheduledAt = "scheduled_at"
//        case slug, status, streams
//        case tournamentID = "tournament_id"
//        case winnerID = "winner_id"
//    }
//}
//
//// MARK: - Game
//struct BracketGame: Codable {
//    let beginAt: Date?
//    let complete, detailedStats: Bool
//    let endAt: Date?
//    let finished, forfeit: Bool
//    let id: Int
//    let length: Int?
//    let matchID, position: Int
//    let status: Status
//    let videoURL: JSONNull?
//    let winner: Winner
//    let winnerType: String?
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
//enum Status: String, Codable {
//    case finished = "finished"
//    case notPlayed = "not_played"
//}
//
//// MARK: - Winner
//struct Winner: Codable {
//    let id: Int?
//    let type: String?
//}
//
//enum BracketWinnerTypeEnum: String, Codable {
//    case team = "Team"
//}
//
//// MARK: - Live
//struct BracketLive: Codable {
//    let opensAt: JSONNull?
//    let supported: Bool
//    let url: JSONNull?
//
//    enum CodingKeys: String, CodingKey {
//        case opensAt = "opens_at"
//        case supported, url
//    }
//}
//
//enum BracketMatchType: String, Codable {
//    case bestOf = "best_of"
//}
//
//// MARK: - OpponentElement
//struct OpponentElement: Codable {
//    let opponent: OpponentOpponent
//    let type: WinnerTypeEnum
//}
//
//// MARK: - OpponentOpponent
//struct OpponentOpponent: Codable {
//    let acronym: String
//    let id: Int
//    let imageURL: String
//    let location: String
//    let modifiedAt: Date
//    let name, slug: String
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
//enum BracketLocation: String, Codable {
//    case kr = "KR"
//}
//
//// MARK: - PreviousMatch
//struct PreviousMatch: Codable {
//    let matchID: Int
//    let type: PreviousMatchType
//
//    enum CodingKeys: String, CodingKey {
//        case matchID = "match_id"
//        case type
//    }
//}
//
//enum PreviousMatchType: String, Codable {
//    case loser = "loser"
//    case winner = "winner"
//}
//
//// MARK: - Streams
//struct BracketStreams: Codable {
//    let english, russian: BracketEnglish
//}
//
//// MARK: - English
//struct BracketEnglish: Codable {
//    let embedURL, rawURL: String?
//
//    enum CodingKeys: String, CodingKey {
//        case embedURL = "embed_url"
//        case rawURL = "raw_url"
//    }
//}
//
//typealias LOLBracket = [LOLBracketElement]
