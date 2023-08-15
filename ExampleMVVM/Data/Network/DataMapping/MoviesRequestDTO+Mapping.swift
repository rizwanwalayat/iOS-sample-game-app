import Foundation

struct MoviesRequestDTO: Encodable {
    let query: String
    let page: Int
    let page_size: Int
}
