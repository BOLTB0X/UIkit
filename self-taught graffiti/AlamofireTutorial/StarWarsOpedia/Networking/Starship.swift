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

// Fetching Multiple Asynchronous Endpoints
// 이는 프로그래머가 필요한 것보다 더 많은 데이터를 제공하지 않고 데이터에 대한 액세스를 제공하기 위해 사용하는 일반적인 패턴
struct Starship: Decodable {
  // 관련 코딩 키와 함께 사용하려는 모든 응답 데이터를 나열
  var name: String
  var model: String
  var manufacturer: String
  var cost: String
  var length: String
  var maximumSpeed: String
  var crewTotal: String
  var passengerTotal: String
  var cargoCapacity: String
  var consumables: String
  var hyperdriveRating: String
  var starshipClass: String
  var films: [String]
  
  enum CodingKeys: String, CodingKey {
    case name
    case model
    case manufacturer
    case cost = "cost_in_credits"
    case length
    case maximumSpeed = "max_atmosphering_speed"
    case crewTotal = "crew"
    case passengerTotal = "passengers"
    case cargoCapacity = "cargo_capacity"
    case consumables
    case hyperdriveRating = "hyperdrive_rating"
    case starshipClass = "starship_class"
    case films
  }
}

// 개별 Starship에 대한 정보를 표시할 수 있기를 원하므로 Starship은 Displayable을 준수해야 함
// Film에서 했던 것처럼 이 확장을 통해 DetailViewController는 모델 자체에서 올바른 레이블과 값을 가져오기 가능
extension Starship: Displayable {
  var titleLabelText: String {
    name
  }
  
  var subtitleLabelText: String {
    model
  }
  
  var item1: (label: String, value: String) {
    ("MANUFACTURER", manufacturer)
  }
  
  var item2: (label: String, value: String) {
    ("CLASS", starshipClass)
  }
  
  var item3: (label: String, value: String) {
    ("HYPERDRIVE RATING", hyperdriveRating)
  }
  
  var listTitle: String {
    "FILMS"
  }
  
  var listItems: [String] {
    films
  }
}
