//
//  LOLBracket.swift
//  LOLCalendar
//
//  Created by 김민국 on 2020/11/04.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let lOLBracket = try? BracketnewJSONDecoder().decode(LOLBracket.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.lOLBracketElementTask(with: url) { lOLBracketElement, response, error in
//     if let lOLBracketElement = lOLBracketElement {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - LOLBracketElement
struct LOLBracketElement: Codable {
    let beginAt: Date
    let detailedStats, draw: Bool
    let endAt: Date
    let forfeit: Bool
    let gameAdvantage: BracketJSONNull?
    let games: [BracketGame]
    let id: Int
    let live: BracketLive
    let liveEmbedURL, liveURL: String
    let matchType: String
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
//   let task = URLSession.shared.gameTask(with: url) { BracketGame, response, error in
//     if let BracketGame = BracketGame {
//       ...
//     }
//   }
//   task.resume()

// MARK: - BracketGame
struct BracketGame: Codable {
    let beginAt: Date?
    let complete, detailedStats: Bool
    let endAt: Date?
    let finished, forfeit: Bool
    let id: Int
    let length: Int?
    let matchID, position: Int
    let status: Status
    let videoURL: BracketJSONNull?
    let winner: Winner
    let winnerType: TypeEnum?

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
    let type: TypeEnum?
}

enum TypeEnum: String, Codable {
    case team = "Team"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.liveTask(with: url) { BracketLive, response, error in
//     if let BracketLive = BracketLive {
//       ...
//     }
//   }
//   task.resume()

// MARK: - BracketLive
struct BracketLive: Codable {
    let opensAt: BracketJSONNull?
    let supported: Bool
    let url: BracketJSONNull?

    enum CodingKeys: String, CodingKey {
        case opensAt = "opens_at"
        case supported, url
    }
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
    let type: TypeEnum
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
    let type: String

    enum CodingKeys: String, CodingKey {
        case matchID = "match_id"
        case type
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.streamsTask(with: url) { BracketStreams, response, error in
//     if let BracketStreams = BracketStreams {
//       ...
//     }
//   }
//   task.resume()

// MARK: - BracketStreams
struct BracketStreams: Codable {
    let english, russian: BracketEnglish
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.englishTask(with: url) { BracketEnglish, response, error in
//     if let BracketEnglish = BracketEnglish {
//       ...
//     }
//   }
//   task.resume()

// MARK: - BracketEnglish
struct BracketEnglish: Codable {
    let embedURL, rawURL: String?

    enum CodingKeys: String, CodingKey {
        case embedURL = "embed_url"
        case rawURL = "raw_url"
    }
}

typealias LOLBracket = [LOLBracketElement]

// MARK: - Helper functions for creating encoders and decoders

func BracketnewJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func BracketnewJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? BracketnewJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func lOLBracketTask(with url: URL, completionHandler: @escaping (LOLBracket?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

// MARK: - Encode/decode helpers

class BracketJSONNull: Codable, Hashable {

    public static func == (lhs: BracketJSONNull, rhs: BracketJSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(BracketJSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for BracketJSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
