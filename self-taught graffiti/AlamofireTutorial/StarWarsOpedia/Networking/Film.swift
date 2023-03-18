/// Copyright (c) 2023 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation

// 반환된 JSON 데이터를 사용하려면 JSON으로 직접 작업하는 것은 중첩 구조로 인해 복잡할 수 있으므로 이를 돕기 위해 데이터를 저장할 모델을 생성
struct Film: Decodable {
  //  코드를 사용하여 API의 필름 끝점에서 데이터를 가져오는 데 필요한 데이터 속성과 CodingKey
  // JSON을 데이터 모델로 전환할 수 있도록 하는 구조체가 Decodable
  
  let id: Int
  let title: String
  let openingCrawl: String
  let director: String
  let producer: String
  let releaseDate: String
  let starships: [String]
  
  enum CodingKeys: String, CodingKey {
    case id = "episode_id"
    case title
    case openingCrawl = "opening_crawl"
    case director
    case producer
    case releaseDate = "release_date"
    case starships
  }
}

// 자세한 정보 표시를 단순화하기 위해 프로토콜(Displayable)을 정의
extension Film: Displayable {
  var titleLabelText: String {
    title
  }
  
  var subtitleLabelText: String {
    "Episode \(String(id))"
  }
  
  var item1: (label: String, value: String) {
    ("DIRECTOR", director)
  }
  
  var item2: (label: String, value: String) {
    ("PRODUCER", producer)
  }
  
  var item3: (label: String, value: String) {
    ("RELEASE DATE", releaseDate)
  }
  
  var listTitle: String {
    "STARSHIPS"
  }
  
  var listItems: [String] {
    starships
  }
}
// 이 확장을 통해 상세 정보 디스플레이의 ViewController가 Model 자체에서 필름에 대한
// 올바른 레이블과 값을 가져올 수 있음
