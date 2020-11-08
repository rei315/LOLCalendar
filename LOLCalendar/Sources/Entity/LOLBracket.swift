
import Foundation

// MARK: - LOLBracketElement
struct LOLBracketElement: Codable {
    let beginAt: Date
    let detailedStats, draw: Bool
    let endAt: Date
    let forfeit: Bool
    let gameAdvantage: JSONNull?
    let games: [BracketGame]
    let id: Int
    let live: BracketLive
    let liveEmbedURL, liveURL: String
    let matchType: BracketMatchType
    let modifiedAt: Date
    let name: String
    let numberOfGames: Int
    let officialStreamURL: String
    let opponents: [OpponentElement]
    let originalScheduledAt: Date
    let previousMatches: [PreviousMatch]
    let scheduledAt: Date
    let slug: String
    let status: Status
    let streams: BracketStreams
    let tournamentID, winnerID: Int

    enum CodingKeys: String, CodingKey {
        case beginAt = "begin_at"
        case detailedStats = "detailed_stats"
        case draw
        case endAt = "end_at"
        case forfeit
        case gameAdvantage = "game_advantage"
        case games, id, live
        case liveEmbedURL = "live_embed_url"
        case liveURL = "live_url"
        case matchType = "match_type"
        case modifiedAt = "modified_at"
        case name
        case numberOfGames = "number_of_games"
        case officialStreamURL = "official_stream_url"
        case opponents
        case originalScheduledAt = "original_scheduled_at"
        case previousMatches = "previous_matches"
        case scheduledAt = "scheduled_at"
        case slug, status, streams
        case tournamentID = "tournament_id"
        case winnerID = "winner_id"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.gameTask(with: url) { game, response, error in
//     if let game = game {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Game
struct BracketGame: Codable {
    let beginAt: Date?
    let complete, detailedStats: Bool
    let endAt: Date?
    let finished, forfeit: Bool
    let id: Int
    let length: Int?
    let matchID, position: Int
    let status: Status
    let videoURL: JSONNull?
    let winner: Winner
    let winnerType: String?

    enum CodingKeys: String, CodingKey {
        case beginAt = "begin_at"
        case complete
        case detailedStats = "detailed_stats"
        case endAt = "end_at"
        case finished, forfeit, id, length
        case matchID = "match_id"
        case position, status
        case videoURL = "video_url"
        case winner
        case winnerType = "winner_type"
    }
}

enum Status: String, Codable {
    case finished = "finished"
    case notPlayed = "not_played"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.winnerTask(with: url) { winner, response, error in
//     if let winner = winner {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Winner
struct Winner: Codable {
    let id: Int?
    let type: String?
}

enum BracketWinnerTypeEnum: String, Codable {
    case team = "Team"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.liveTask(with: url) { live, response, error in
//     if let live = live {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Live
struct BracketLive: Codable {
    let opensAt: JSONNull?
    let supported: Bool
    let url: JSONNull?

    enum CodingKeys: String, CodingKey {
        case opensAt = "opens_at"
        case supported, url
    }
}

enum BracketMatchType: String, Codable {
    case bestOf = "best_of"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.opponentElementTask(with: url) { opponentElement, response, error in
//     if let opponentElement = opponentElement {
//       ...
//     }
//   }
//   task.resume()

// MARK: - OpponentElement
struct OpponentElement: Codable {
    let opponent: OpponentOpponent
    let type: WinnerTypeEnum
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.opponentOpponentTask(with: url) { opponentOpponent, response, error in
//     if let opponentOpponent = opponentOpponent {
//       ...
//     }
//   }
//   task.resume()

// MARK: - OpponentOpponent
struct OpponentOpponent: Codable {
    let acronym: String
    let id: Int
    let imageURL: String
    let location: String
    let modifiedAt: Date
    let name, slug: String

    enum CodingKeys: String, CodingKey {
        case acronym, id
        case imageURL = "image_url"
        case location
        case modifiedAt = "modified_at"
        case name, slug
    }
}

enum BracketLocation: String, Codable {
    case kr = "KR"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.previousMatchTask(with: url) { previousMatch, response, error in
//     if let previousMatch = previousMatch {
//       ...
//     }
//   }
//   task.resume()

// MARK: - PreviousMatch
struct PreviousMatch: Codable {
    let matchID: Int
    let type: PreviousMatchType

    enum CodingKeys: String, CodingKey {
        case matchID = "match_id"
        case type
    }
}

enum PreviousMatchType: String, Codable {
    case loser = "loser"
    case winner = "winner"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.streamsTask(with: url) { streams, response, error in
//     if let streams = streams {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Streams
struct BracketStreams: Codable {
    let english, russian: BracketEnglish
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.englishTask(with: url) { english, response, error in
//     if let english = english {
//       ...
//     }
//   }
//   task.resume()

// MARK: - English
struct BracketEnglish: Codable {
    let embedURL, rawURL: String?

    enum CodingKeys: String, CodingKey {
        case embedURL = "embed_url"
        case rawURL = "raw_url"
    }
}

typealias LOLBracket = [LOLBracketElement]

// MARK: - URLSession response handlers

//extension URLSession {
//    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        return self.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                completionHandler(nil, response, error)
//                return
//            }
//            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
//        }
//    }
//
//    func lOLBracketTask(with url: URL, completionHandler: @escaping (LOLBracket?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        return self.codableTask(with: url, completionHandler: completionHandler)
//    }
//}
