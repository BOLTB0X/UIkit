/*
 See LICENSE folder for this sample’s licensing information.
 */

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.
        // application(_:didFinishLaunchingWithOptions:) 함수에서 내비게이션 바의 기본 모양의 색조 색상을 변경
        // UINavigationBar 클래스의 모양에 변경 사항을 적용하여 앱에 있는 모든 탐색 모음의 기본 모양을 변경
        UINavigationBar.appearance().tintColor = .todayPrimaryTint
        // Today에서 사용할 색상은 자산 카탈로그에서 정의
        UINavigationBar.appearance().backgroundColor = .todayNavigationBackground
        // 새 UINavigationBarAppearance를 만들고 이를 navBarAppearance라는 상수에 할당
        let navBarAppearance = UINavigationBarAppearance()
        // 인스턴스 메서드 configureWithOpaqueBackground()를 호출하여 현재 테마에 적합한 불투명 색상으로 탐색 모음을 구성
        navBarAppearance.configureWithOpaqueBackground()
        // 목록 보기의 콘텐츠 중 일부는 내비게이션 바 뒤에 나타남
        // 스크롤된 콘텐츠가 내비게이션 바에 도달하면 UIKit은 기본 모양 설정을 적용
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(
            name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(
        _ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}
