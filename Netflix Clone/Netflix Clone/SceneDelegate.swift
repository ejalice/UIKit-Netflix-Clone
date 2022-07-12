//
//  SceneDelegate.swift
//  Netflix Clone
//
//  Created by eunji on 2022/07/11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = MainTabBarViewController()
        window?.makeKeyAndVisible()
        /* UIWindow
         : View들을 담는 container
         : 이벤트를 전달해주는 매개체 (사용자 인터페이스에 배경을 제공하며 에번트 처리 행동을 제공하는 객체)
         - (앞) UILabel / UITextField / UIButton << UIView -> UIViewController << UIWindow << UIApplication -> UIApplicationDelegate (뒤)
         - storyboard가 아닌 코드로 view를 구성할 때, window rootViewController 수정은 필수!
         */
        
        /* window.makeKeyAndVisible()
         : keyWindow로 설정.
          (keyWindow == window가 여러개 존재할 때, 가장 앞쪽에 배치된 window)
         : window의 rootViewController를 위에서 설정해줬으면 makeKeyAndVisible()을 부르면 지정한 rootViewController가 상호작용을 받는 현재 화면으로 세팅.
         */
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

