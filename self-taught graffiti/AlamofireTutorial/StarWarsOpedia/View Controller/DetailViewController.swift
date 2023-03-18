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

class DetailViewController: UIViewController {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var item1TitleLabel: UILabel!
  @IBOutlet weak var item1Label: UILabel!
  @IBOutlet weak var item2TitleLabel: UILabel!
  @IBOutlet weak var item2Label: UILabel!
  @IBOutlet weak var item3TitleLabel: UILabel!
  @IBOutlet weak var item3Label: UILabel!
  @IBOutlet weak var listTitleLabel: UILabel!
  @IBOutlet weak var listTableView: UITableView!
  
  var data: Displayable?
  var listData: [Displayable] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    commonInit()
    
    listTableView.dataSource = self
    
    fetchList()
  }
  
  private func commonInit() {
    guard let data = data else { return }
    
    titleLabel.text = data.titleLabelText
    subtitleLabel.text = data.subtitleLabelText
    
    item1TitleLabel.text = data.item1.label
    item1Label.text = data.item1.value
    
    item2TitleLabel.text = data.item2.label
    item2Label.text = data.item2.value
    
    item3TitleLabel.text = data.item3.label
    item3Label.text = data.item3.value
    
    listTitleLabel.text = data.listTitle
  }
}

// MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
  // Film과 Starship은 모두 Displayable이므로 네트워크 요청을 수행하는 일반 도우미를 작성 가능
  // 가져오는 항목의 유형만 알면 결과를 적절하게 디코딩 가능
  private func fetch<T: Decodable & Displayable>(_ list: [String], of: T.Type) {
    var items: [T] = []
    // 목록 항목당 하나씩 여러 번 호출해야 하며 이러한 호출은 비동기식이며 순서 없이 반환 가능
    // 이를 처리하기 위해 디스패치 그룹을 사용하여 모든 호출이 완료되면 알림을 받음
    let fetchGroup = DispatchGroup()
    
    // 목록의 각 항목을 반복
    list.forEach { (url) in
      // 디스패치 그룹에 들어가고 있음을 알림
      fetchGroup.enter()
      // starship 끝점에 Alamofire 요청을 만들고 응답을 확인하고 응답을 적절한 유형의 항목으로 디코딩
      AF.request(url).validate().responseDecodable(of: T.self) { (response) in
        if let value = response.value {
          items.append(value)
        }
        // 요청의 완료 핸들러에서 디스패치 그룹에 떠날 것임을 알림
        fetchGroup.leave()
      }
    }
    
    fetchGroup.notify(queue: .main) {
      self.listData = items
      self.listTableView.reloadData()
    }
  }
  
  func fetchList() {
    // data는 optional
    // 다른 작업을 수행하기 전에 데이터가 nil이 아닌지 확인
    guard let data = data else { return }
    
    // 데이터 type으로 helper 메서드를 호출하는 방법을 결정
    switch data {
    case is Film:
      fetch(data.listItems, of: Starship.self)
      // 이것은 일반 도우미에게 주어진 우주선에 대한 영화 목록을 가져오도록 지시
    case is Starship:
      fetch(data.listItems, of: Film.self)
    default:
      print("Unknown type: ", String(describing: type(of: data)))
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return listData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
    // 코드는 목록 데이터의 적절한 제목으로 셀의 textLabel을 설정
    cell.textLabel?.text = listData[indexPath.row].titleLabelText
    return cell
  }
}
