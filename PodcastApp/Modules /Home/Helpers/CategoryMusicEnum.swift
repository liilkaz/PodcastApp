import Foundation

enum CategoryMusic: String, CaseIterable {
    case classic = "Classic"
    case holiday = "Holiday"
    case jazz = "Jazz"
    case pop = "Pop"
    case childrens = "Children's"
    case world = "World"
    case hip_hop = "Hip-Hop"
    case rock = "Rock"
    case electronic = "Electronic"

    var genreId: Int {
        switch self {
        case .classic: return 5
        case .holiday: return 8
        case .jazz: return 11
        case .childrens: return 4
        case .pop: return 14
        case .world: return 16
        case .hip_hop: return 18
        case .rock: return 21
        case .electronic: return 7
        }
    }
}
