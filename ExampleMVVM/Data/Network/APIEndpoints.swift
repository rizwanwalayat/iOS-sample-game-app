import Foundation

struct APIEndpoints {
    
    static func getMovies(with moviesRequestDTO: MoviesRequestDTO) -> Endpoint<MoviesResponseDTO> {

        return Endpoint(
            path: "games",
            method: .get,
            queryParametersEncodable: moviesRequestDTO
        )
    }

    static func getMoviePoster(path: String, width: Int) -> Endpoint<Data> {

        let sizes = [92, 154, 185, 342, 500, 780]
        let closestWidth = sizes
            .enumerated()
            .min { abs($0.1 - width) < abs($1.1 - width) }?
            .element ?? sizes.first!
        
        return Endpoint(
            path: "\(closestWidth)\(path)",
            isFullPath: true,
            method: .get,
            responseDecoder: RawDataResponseDecoder()
        )
    }
    
    static func getGamePoster(path: String) -> Endpoint<Data> {

        return Endpoint(
            path: "\(path)",
            isFullPath: true,
            method: .get,
            responseDecoder: RawDataResponseDecoder()
        )
    }
}
