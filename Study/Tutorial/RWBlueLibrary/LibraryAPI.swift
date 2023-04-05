import Foundation

// MARK: LibraryAPI
final class LibraryAPI {
  // 1  shared static constant 접근 방식은 다른 객체가 싱글톤 객체 LibraryAPI에 액세스할 수 있도록 함
  static let shared = LibraryAPI()
  // 2 개인 이니셜라이저는 외부에서 LibraryAPI의 새 인스턴스 생성을 방지
  private init() {

  }
  
  // isOnline은 추가 또는 삭제된 앨범과 같이 앨범 목록에 대한 변경 사항으로 서버를 업데이트해야 하는지 여부를 결정
  // HTTP 클라이언트는 실제로 실제 서버에서 작동하지 않으며 파사드 패턴의 사용법을 보여주기 위한 것일 뿐이므로 isOnline은 항상 false
  private let persistencyManager = PersistencyManager()
  private let httpClient = HTTPClient()
  private let isOnline = false
  
  func getAlbums() -> [Album] {
    return persistencyManager.getAlbums()
  }
    
  func addAlbum(_ album: Album, at index: Int) {
    persistencyManager.addAlbum(album, at: index)
    if isOnline {
      httpClient.postRequest("/api/addAlbum", body: album.description)
    }
  }
    
  func deleteAlbum(at index: Int) {
    persistencyManager.deleteAlbum(at: index)
    if isOnline {
      httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
    }
  }

}
