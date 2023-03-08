# Xcode 프로젝트 구조

## Source files, Configuration files, Build settings

<br/>

# UIKit 기능 관련된 요소 정리

## View Controller : 사용자 인터페이스 관리

> 뷰와 데이터 모델 간의 다리 역할
> 각 뷰 컨트롤러는 뷰 계층 구조 관리, 뷰의 콘텐츠 업데이트, 사용자 인터페이스의 이벤트 응답을 담당
> Interface Builder를 사용하여 collection view controller를 생성
> <br/>

## Collection View

> 그리드, 열, 행 또는 테이블에 셀을 표시
> 테이블처럼 일정한 가로 세로 개수를 가진 목록 Object
> 사진첩이나 갤러리에 주로 사용
> <br/>

## 초기 View Controller 설정

> Controller를 변경하면 속성 인스펙터에서 Is Initial View Controller 체크박스를 선택하여 장면을 스토리보드 진입점으로 설정
> 앱에는 여러 개의 스토리보드가 있을 수 있므로 앱 프로젝트 파일의 기본 인터페이스 설정에 따라 앱이 시작될 때 로드되는 스토리보드가 결정
> <br/>

## MVC

![](https://docs-assets.developer.apple.com/published/ba3a9d5e35b72a6ac9253078a162e091/UIK010_030-intro~dark@2x.png)

> UIKit 앱의 일반적인 디자인 패턴인 MVC(Model-View-Controller) 디자인 패턴
> <br/>
