import UIKit

var str = "Hello, playground"

struct Swifter {
  let fullName: Array<String>
  let id: Int
  let twitter: URL
  
  init(fullName: Array<String>, id: Int, twitter: URL) { // default struct initializer
    self.fullName = fullName
    self.id = id
    self.twitter = twitter
    
  }
}

extension Swifter: Decodable {
  enum MyStructKeys: String, CodingKey { // declaring our keys
    case fullName = "fullName"
    case id = "id"
    case twitter = "twitter"
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: MyStructKeys.self) // defining our (keyed) container
    print(container.allKeys)
    let fullName: Array<String> = try container.decode(Array<String>.self, forKey: .fullName) // extracting the data
    let id: Int = try container.decode(Int.self, forKey: .id) // extracting the data
    let twitter: URL = try container.decode(URL.self, forKey: .twitter) // extracting the data
    
    self.init(fullName: fullName, id: id, twitter: twitter) // initializing our struct
  }
}

let json = """
{
 "fullName": ["Federico Zanetello"]
}
""".data(using: .utf8)! // our native (JSON) data
print(String(json))
let myStruct = try JSONDecoder().decode(Swifter.self, from: json) // decoding our data
print(myStruct) // decoded!
