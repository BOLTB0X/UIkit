import Foundation

// MARK: PersistencyManager
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
