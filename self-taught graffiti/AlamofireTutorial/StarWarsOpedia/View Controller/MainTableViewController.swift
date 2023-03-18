/// Copyright (c) 2019 Razeware LLC
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

import UIKit
import Alamofire

class MainTableViewController: UITableViewController {
  var films: [Film] = [] // 사용자가 검색을 취소하면 영화 목록을 다시 표시
  var items: [Displayable] = []
  var selectedItem: Displayable? // 현재 선택한 영화를 이 속성에 저장 가능

  @IBOutlet weak var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    
    fetchFilms() // 추가
  }
  
  // tableView 오버라이딩
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count // 필름 수만큼 셀을 표시할 수 있음

  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
    
    // 여기에서 Displayable을 통해 제공되는 속성을 사용하여 영화 이름과 에피소드 ID로 셀을 설정
    let item = items[indexPath.row]
    cell.textLabel?.text = item.titleLabelText
    cell.detailTextLabel?.text = item.subtitleLabelText
    return cell
  }
  
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    // 선택한 행에서 필름을 가져와 selectedItem에 저장
    selectedItem = items[indexPath.row]
    return indexPath
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let destinationVC = segue.destination as? DetailViewController else {
      return
    }
    destinationVC.data = selectedItem // 위 오버라이딩으로 selectedItem에 저장했으니
    // 나타낼 데이터로 사용자의 선택을 설정
  }
}

// MARK: - UISearchBarDelegate
extension MainTableViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    // 이 코드는 검색창에 입력된 텍스트를 가져오고 방금 구현한 새 searchStarships(for:) 메서드를 호출
    
    guard let shipName = searchBar.text else { return }
    searchStarships(for: shipName)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = nil
    searchBar.resignFirstResponder()
    items = films
    tableView.reloadData()
  }
}

// MARK: - Alamofire
extension MainTableViewController {
  func fetchFilms() {
    // 1
    // Alamofire는 네임스페이스를 사용하므로 AF를 사용하는 모든 호출에 접두사를 지정해야 함
    // request(_:method:parameters:encoding:headers:interceptor:)는 데이터의 끝점을 허용
    // URL을 문자열로 보내고 기본 매개변수 값을 사용
    let request = AF.request("https://swapi.dev/api/films")
    // 2
    // 요청에서 제공된 응답을 JSON으로 가져옵
    
    // 이를
//    request.responseJSON { (data) in
//      print(data) // 디버깅 목적으로 JSON data print
//    }
    // 대체함
    // 이제 응답을 JSON으로 변환하는 대신 내부 데이터 모델인 Films로 변환
//    request.responseDecodable(of: Films.self) { (response) in
//      guard let films = response.value else { return }
//      print(films.all[0].title) // 디버깅을 위해 검색된 첫 번째 영화의 제목 print
//    }
    // Alamofire는 한 메서드의 응답을 다른 메서드의 입력으로 연결하여 작동하는 메서드 체인을 사용
    // 기존 코드의 가독성을 위해 대체
    // 한 줄로 JSON으로 변환하는 대신 내부 데이터 모델인 Films로 변환과 유효성 검사도 추가 할수 있음
    // 응답이 200-299 범위의 HTTP 상태 코드를 반환했는지 확인하여 응답을 검증하고 응답을 데이터 모델로 디코딩
    AF.request("https://swapi.dev/api/films")
      .validate()
      .responseDecodable(of: Films.self) { (response) in
        guard let films = response.value else { return }
        print(films.all[0].title) // 이 속성을 사용하여 서버에서 받은 정보 배열을 저장
        
        self.items = films.all
        self.tableView.reloadData() // 검색된 모든 영화가 항목에 할당되고 테이블 보기가 다시 로드
      }
  }
  
  func searchStarships(for name: String) {
    // 1
    // 데이터에 액세스하는 데 사용할 URL을 설정
    let url = "https://swapi.dev/api/starships"
    // 2
    // endpoint로 보낼 키-값 매개변수를 설정
    let parameters: [String: String] = ["search": name]
    // 3
    // 매개변수를 추가
    // 또한 검증을 수행하고 응답을 Starships로 디코딩
    AF.request(url, parameters: parameters).validate()
      .responseDecodable(of: Starships.self) { response in
        guard let starships = response.value else { return }
        // 4
        // 마지막으로 요청이 완료되면 우주선 목록을 테이블 뷰의 데이터로 할당하고 테이블 뷰를 다시 로드
        self.items = starships.all
        self.tableView.reloadData()
    }
  }
}
