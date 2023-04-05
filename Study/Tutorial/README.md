# Design Patterns on iOS 

[kodeco의 Design Patterns on iOS using Swift](https://www.kodeco.com/477-design-patterns-on-ios-using-swift-part-1-2)을 따라가면서 이론이나 코드의 동작방식의 설명을 추가하여 진행
<br/>

## Intro
프로그램을 재사용성이 높게 잘 설계하는 것을 지향해야함. 메모리관리 측면이나 성능보장 측면에서도 이 재사용성은 중요하므로 디자인패턴을 채택하며 개발을 진행함
<br/>

Cocoa 패턴의 자세한 정리글은 [Cocoa]() 참조
<br/>

## design patterns

- 생성 패턴(Creational Patterns): Singleton
<br/>

- 구조 패턴(Structural Patterns): MVC, Adapter, Facade, Decorator
<br/>

- 행위 패턴(Behavioral Patterns): Observer
<br/>

## MVC(Model-View-Controller)

MVC(Model-View-Controller)는 Cocoa의 빌딩 블록 중 하나이며 가장 많이 사용되는 디자인 패턴
<br/>
그래서 오픈 소스가 정말 많음
<br/>

MVC 패턴의 자세한 정리글은 [MVC]() 참조
<br/>

## The Singleton Pattern
> Singleton 디자인 패턴은 주어진 클래스에 대해 하나의 인스턴스만 존재하고 해당 인스턴스에 대한 전역 액세스
> <br/>

Class의 인스턴스를 정확히 하나만 갖는 것이 웬만하면 좋음
<br/> 

ex) 
- App의 인스턴스가 하나뿐이고 장치의 기본 화면이 하나뿐이므로 각각의 인스턴스가 하나만 필요 또는 전역 구성 처리기 클래스를 사용 

<br/>

- 구성 파일과 같은 단일 공유 리소스에 대한 스레드 안전 액세스를 구현하는 것이 가능한 동시에 구성 파일을 수정하는 많은 클래스를 갖는 것보다 쉬움

이 튜토리얼에서 이런식으로 적용

```swift
final class LibraryAPI {
  // 1  shared static constant 접근 방식은 다른 객체가 싱글톤 객체 LibraryAPI에 액세스할 수 있도록 함
  static let shared = LibraryAPI()
  // 2 개인 이니셜라이저는 외부에서 LibraryAPI의 새 인스턴스 생성을 방지
  private init() {

  }
}
```

또한 Model을 정의하고 이를 관리할 ***PersistencyManager***를 생성
<br/>

```swift
// 여기에서 앨범 데이터를 보관
// 배열은 변경 가능하므로 앨범을 쉽게 추가하고 삭제 가능

final class PersistencyManager {
  private var albums = [Album]()
  
  init() {
    // 이니셜라이저를 추가
    //Dummy list of albums
    let album1 = Album(title: "Best of Bowie",
                       artist: "David Bowie",
                       genre: "Pop",
                       coverUrl: "https://s3.amazonaws.com/CoverProject/album/album_david_bowie_best_of_bowie.png",
                       year: "1992")
    
    let album2 = Album(title: "It's My Life",
                       artist: "No Doubt",
                       genre: "Pop",
                       coverUrl: "https://s3.amazonaws.com/CoverProject/album/album_no_doubt_its_my_life_bathwater.png",
                       year: "2003")
    
    let album3 = Album(title: "Nothing Like The Sun",
                       artist: "Sting",
                       genre: "Pop",
                       coverUrl: "https://s3.amazonaws.com/CoverProject/album/album_sting_nothing_like_the_sun.png",
                       year: "1999")
    
    let album4 = Album(title: "Staring at the Sun",
                       artist: "U2",
                       genre: "Pop",
                       coverUrl: "https://s3.amazonaws.com/CoverProject/album/album_u2_staring_at_the_sun.png",
                       year: "2000")
    
    let album5 = Album(title: "American Pie",
                       artist: "Madonna",
                       genre: "Pop",
                       coverUrl: "https://s3.amazonaws.com/CoverProject/album/album_madonna_american_pie.png",
                       year: "2000")
    
    albums = [album1, album2, album3, album4, album5]
  }
  
  func getAlbums() -> [Album] {
    return albums
  }
  
  func addAlbum(_ album: Album, at index: Int) {
    if (albums.count >= index) {
      albums.insert(album, at: index)
    } else {
      albums.append(album)
    }
  }
  
  func deleteAlbum(at index: Int) {
    albums.remove(at: index)
  }
}
```

## The Facade Design Pattern
> Facade 디자인 패턴은 복잡한 하위 시스템에 대한 단일 인터페이스를 제공
> <br/>
> 사용자를 일련의 클래스 및 해당 API에 노출하는 대신 하나의 간단한 통합 API만 노출
> <br/>

Facade 패턴의 자세한 정리글은 [Facade]() 참조
<br/>

<img src = "https://files.koenig.kodeco.com/uploads/2017/05/design-patterns-part1-facade-1-480x87.png">
<br/>

앨범 data를 로컬에 저장하는 PersistencyManager와 원격 통신을 처리하는 HTTPClient가 있음
<br/> 
프로젝트의 다른 클래스는 LibraryAPI의 외관 뒤에 숨어 있으므로 인식 x
<br/>

```swift
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
```
프로퍼티에 담아서 메소드를 편리하게 이용
<br/> 

## The Decorator Design Pattern
코드를 수정하지 않고 개체에 동작과 책임을 동적으로 추가
<br/>
클래스를 다른 개체로 래핑하여 클래스의 동작을 수정하는 서브클래싱의 대안
<br/>
Swift에는 이 패턴의 두 가지 매우 일반적인 구현이 두 가지로 나뉨

Extensions 패턴의 자세한 정리글은 [Extensions]() 참조
<br/>

Delegation 패턴의 자세한 정리글은 [Delegation]() 참조
<br/>

### Extensions

이 튜토리얼에서는 앨범 제목은 어디에서 가져오기 위해 사용
<br/> 
앨범은 model이므로 data를 표시하는 방법은 중요 X, Album 구조체에 이 기능을 추가하려면 외부 코드가 필요
<br/>

*** Album 구조체의 Extensions을 만들 것 *** 
<br/>

UITableView와 함께 쉽게 사용할 수 있는 데이터 구조를 반환하는 새로운 메서드를 정의
<br/>

```swift
// Album Model에 add
// typealias는 테이블 뷰가 데이터 행을 표시하는 데 필요한 모든 정보를 포함하는 튜플을 정의
typealias AlbumData = (title: String, value: String)

// 액세스하려면 다음 확장을 추가
extension Album {
  var tableRepresentation: [AlbumData] {
    return [
      ("Artist", artist),
      ("Album", title),
      ("Genre", genre),
      ("Year", year)
    ]
  }
}
```
즉 extension으로 앨범에서 직접 속성을 사용, 앨범 구조에 추가했지만 수정 X
<br/>
-> 앨범의 UITableView 같은 표현을 반환 가능
<br/>

### Delegate
```swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  guard let albumData = currentAlbumData else {
    return 0
  }
  return albumData.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
  if let albumData = currentAlbumData {
    let row = indexPath.row
    cell.textLabel!.text = albumData[row].title
    cell.detailTextLabel!.text = albumData[row].value
  }
  return cell
}

```

## 참고
https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=jvioonpe&logNo=220227413391
<br/>
