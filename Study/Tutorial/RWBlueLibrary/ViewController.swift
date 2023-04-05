/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

final class ViewController: UIViewController {
  
  private enum Constants {
    static let CellIdentifier = "Cell"
  }

  @IBOutlet var tableView: UITableView!
  @IBOutlet var undoBarButtonItem: UIBarButtonItem!
  @IBOutlet var trashBarButtonItem: UIBarButtonItem!
  
  private var currentAlbumIndex = 0
  private var currentAlbumData: [AlbumData]?
  private var allAlbums = [Album]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //1
    // API를 통해 모든 앨범 목록을 가져옴
    // 계획은 PersistencyManager가 아닌 LibraryAPI의 파사드를 직접 사용하는 것
    allAlbums = LibraryAPI.shared.getAlbums()
    
    //2
    // UITableView를 설정하는 곳
    // view controller가 UITableView 데이터 소스임을 선언
    // 따라서 UITableView에 필요한 모든 정보는 뷰 컨트롤러에서 제공
    // 테이블 view가 스토리보드에 생성된 경우 실제로 스토리보드에서 대리자와 데이터 소스를 설정할 수 있
    tableView.dataSource = self
    
    showDataForAlbum(at: currentAlbumIndex)
  }
  
  // 앨범 배열에서 필요한 앨범 데이터를 가져옴
  // 새 data를 표시하려면 UITableView에서 reloadData를 호출하기만 하면 됨
  // 테이블 view가 얼마나 많은 섹션이 테이블 view에 나타나야 하는지, 각 섹션에 얼마나 많은 행이 있는지, 각 셀이 어떻게 보여야 하는지 등과 같은 data 소스를 묻도록 함
  private func showDataForAlbum(at index: Int) {
    // defensive code: make sure the requested index is lower than the amount of albums
    if (index < allAlbums.count && index > -1) {
      // fetch the album
      let album = allAlbums[index]
      // save the albums data to present it later in the tableview
      currentAlbumData = album.tableRepresentation
    } else {
      currentAlbumData = nil
    }
    // we have the data we need, let's refresh our tableview
    tableView.reloadData()
  }

}

extension ViewController: UITableViewDataSource {
  // 앨범의 "장식된" 표현에 있는 항목 수와 일치하는 테이블 보기에 표시할 행 수를 반환
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let albumData = currentAlbumData else {
      return 0
    }
    return albumData.count
  }
  
  // 제목과 해당 값이 포함된 셀을 생성하고 반환
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier, for: indexPath)
    if let albumData = currentAlbumData {
      let row = indexPath.row
      cell.textLabel!.text = albumData[row].title
      cell.detailTextLabel!.text = albumData[row].value
    }
    return cell
  }
  
}
