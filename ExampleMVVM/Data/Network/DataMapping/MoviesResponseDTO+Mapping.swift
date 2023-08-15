import Foundation

// MARK: - Data Transfer Object

struct MoviesResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "count"
        case movies = "results"
    }
    var page: Int = 1
    var totalPages: Int
    let movies: [MovieDTO]
}

extension MoviesResponseDTO {
    struct MovieDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case title = "name"
            case genre
            case posterPath = "background_image"
            case overview
            case releaseDate = "metacritic"
        }
        enum GenreDTO: String, Decodable {
            case adventure
            case scienceFiction = "science_fiction"
        }
        let id: Int
        let title: String?
        let genre: GenreDTO?
        let posterPath: String?
        let overview: String?
        let releaseDate: Int?
    }
}

// MARK: - Mappings to Domain

extension MoviesResponseDTO {
    func toDomain() -> MoviesPage {
        return .init(page: 1,
                     totalPages: totalPages ?? 1,
                     movies: movies.map { $0.toDomain() })
    }
}

extension MoviesResponseDTO.MovieDTO {
    func toDomain() -> Movie {
        return .init(id: Movie.Identifier(id),
                     title: title,
                     genre: genre?.toDomain(),
                     posterPath: posterPath,
                     overview: overview,
                     releaseDate: releaseDate)
    }
}

extension MoviesResponseDTO.MovieDTO.GenreDTO {
    func toDomain() -> Movie.Genre {
        switch self {
        case .adventure: return .adventure
        case .scienceFiction: return .scienceFiction
        }
    }
}

// MARK: - Private

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
}()
