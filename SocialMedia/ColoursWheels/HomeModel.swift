//
//  HomeModel.swift
//  SocialMedia
//
//  Created by ABDUL KADIR ANSARI on 15/04/22.
//

import Foundation
struct HomeJsonDataVo: Codable {
    let slider: Slider
    let allGenre: [AllGenre]
    let latestTvseries: [LatestTvsery]
    let featuresGenreAndMovie: [AllGenre]

    enum CodingKeys: String, CodingKey {
        case slider
        case allGenre = "all_genre"
        case latestTvseries = "latest_tvseries"
        case featuresGenreAndMovie = "features_genre_and_movie"
    }
}

// MARK: - AllGenre
struct AllGenre: Codable {
    let genreID, name, allGenreDescription, slug: String
    let url: String
    let imageURL: String?
    let videos: [LatestTvsery]?

    enum CodingKeys: String, CodingKey {
        case genreID = "genre_id"
        case name
        case allGenreDescription = "description"
        case slug, url
        case imageURL = "image_url"
        case videos
    }
}

// MARK: - LatestTvsery
struct LatestTvsery: Codable {
    let videosID, title, latestTvseryDescription, slug: String
    let release: String
    let isTvseries: String?
    let isPaid: String
    let runtime: JSONNull?
    let videoQuality: VideoQuality
    let thumbnailURL, posterURL: String

    enum CodingKeys: String, CodingKey {
        case videosID = "videos_id"
        case title
        case latestTvseryDescription = "description"
        case slug, release
        case isTvseries = "is_tvseries"
        case isPaid = "is_paid"
        case runtime
        case videoQuality = "video_quality"
        case thumbnailURL = "thumbnail_url"
        case posterURL = "poster_url"
    }
}

enum VideoQuality: String, Codable {
    case sq = "SQ"
}

// MARK: - Slider
struct Slider: Codable {
    let sliderType: String
    let slide: [Slide]

    enum CodingKeys: String, CodingKey {
        case sliderType = "slider_type"
        case slide
    }
}

// MARK: - Slide
struct Slide: Codable {
    let id, title, slideDescription: String
    let imageLink: String
    let slug, actionType, actionBtnText: String
    let actionID, actionURL: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, title
        case slideDescription = "description"
        case imageLink = "image_link"
        case slug
        case actionType = "action_type"
        case actionBtnText = "action_btn_text"
        case actionID = "action_id"
        case actionURL = "action_url"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
