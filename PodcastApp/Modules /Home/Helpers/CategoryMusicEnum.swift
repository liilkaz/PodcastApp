import Foundation

enum CategoryMusic: String, CaseIterable {
    case arts = "Arts"
    case books = "Books"
    case design = "Design"
    case fashion = "Fashion"
    case beauty = "Beauty"
    case food = "Food"
    case performing = "Performing"
    case visual = "Visual"
    case business = "Business"
    case careers = "Careers"
    case entrepreneurship = "Entrepreneurship"
    case investing = "Investing"
    case management = "Management"
    case marketing = "Marketing"
    case non_profit = "Non-Profit"
    case comedy = "Comedy"
    case interviews = "Interviews"
    case improv = "Improv"
    case stand_up = "Stand-Up"
    case education = "Education"

    var genreId: Int {
        switch self {
        case .arts: return 1
        case .books: return 2
        case .design: return 3
        case .fashion: return 4
        case .beauty: return 5
        case .food: return 6
        case .performing: return 7
        case .visual: return 8
        case .business: return 9
        case .careers: return 10
        case .entrepreneurship: return 11
        case .investing: return 12
        case .management: return 13
        case .marketing: return 14
        case .non_profit: return 15
        case .comedy: return 16
        case .interviews: return 17
        case .improv: return 18
        case .stand_up: return 19
        case .education: return 20
        }
    }
}
