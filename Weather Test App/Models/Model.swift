
import Foundation

struct Model: Codable {
	let location : Location?
	let current : Currents?

	enum CodingKeys: String, CodingKey {

		case location = "location"
		case current = "current"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		location = try values.decodeIfPresent(Location.self, forKey: .location)
		current = try values.decodeIfPresent(Currents.self, forKey: .current)
	}

}
