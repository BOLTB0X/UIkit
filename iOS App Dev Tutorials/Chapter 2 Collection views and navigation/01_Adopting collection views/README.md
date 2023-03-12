# Adopting collection views

> Collection views는 정렬된 데이터 항목 컬렉션을 관리하고 사용자 정의 가능한 레이아웃을 사용하여 이를 표시
> <br/>
> Collection views는 컬렉션 보기를 채택하면 데이터, 레이아웃 및 프레젠테이션의 문제를 분리하여 더 강력하고 확장 가능한 앱 만들 수 있음
> <br/>

즉 Collection views를 튜토리얼 진행하는 챕터임
<br/>

## 왜 사용할까?

<img src="https://docs-assets.developer.apple.com/published/2b91a92aa3887bd76cfa9540e557923f/UIK_015-010~dark@2x.png" width="200" height="200"/>
<br/>
악 앱에서 컬렉션 보기는 음악을 긴 노래 목록으로 표시하거나 인기도, 장르 또는 분위기별로 섹션으로 구성을 해야할 때가 있음
<br/>
셀을 섹션으로 유연하게 구성을 스크롤 가능한 view의 셀로 효율적으로 표시하는 UICollectionView 클래스를 제공하는 것이 collection views
<br/>

## collection view의 장점

> UIKit은 컬렉션 보기를 생성하고 업데이트하기 위해 diffable 데이터 소스, 구성 가능한 레이아웃 및 셀 구성을 제공합니다.
> <br/>
> 이러한 구성 요소는 앱을 모듈식으로 유지하고 더 쉽게 작성하고 유지 관리하는 데 좋음
> <br/>
> tutorial 발취
> <br/>

즉, collection view는 많은 레이아웃 및 프레젠테이션 책임을 처리하므로 데이터 관리에 집중할 수 있음
<br/>

## UICollectionViewDiffableDataSource

위에서 정리했듯히 collection view는 데이터 관리에 집중하려면 비교 가능한 데이터 소스를 생성할 필요함
<br/>
UIKit에는 UICollectionViewDiffableDataSource 제네릭 클래스를 제공
<br/>
collection view의 데이터에 대한 업데이트를 효율적이고 안전하게 관리하는 동작을 제공
<br/>
Diffable datasource는 차이를 스스로 계산해서 업데이트 된 뷰의 데이터를 전달한다면 기존과 달라진 부분을 스스로 계산하여 달라진 부분만 업데이트가 가능한 좋은 클래스임
<br/>

```swift
typealias DataSource = UICollectionViewDiffableDataSource<Int, ReminderItem>

func makeDataSource() -> DataSource {
    let reminderCellRegistration = self.reminderCellRegistration()
    return DataSource(collectionView: collectionView) {
        collectionView, indexPath, item -> UICollectionViewCell? in
        return collectionView.dequeueConfiguredReusableCell(
            using: reminderCellRegistration, for: indexPath, item: item)
    }
}

lazy var dataSource = makeDataSource()
```

<br/>
init(collectionView:cellProvider:) 초기화에 전달하여 인스턴스를 만들 수 있음
<br/>
셀 공급자는 재사용 가능한 셀 풀에서 셀을 가져오고 구성을 사용하여 콘텐츠 및 스타일을 추가하는 기능
<br/>
TODO : 계속 업데이트 할 예정
<br/>

## 셀 구성의 정의(Defining cell configurations)

> 필요에 따라 셀 공급자에게 셀을 요청합니다.
> <br/>

collection view화면 밖으로 스크롤되는 셀을 자동으로 재활용하므로 앱에서 적은 수의 셀만 생성하면 됩
<br/>
이 셀 재사용으로 인해 부드러운 스크롤이 가능하고 앱의 메모리 요구 사항이 줄어듬
<br/>

더 자세한 사항은 추후 collection view 스터디 추가예정
<br/>
