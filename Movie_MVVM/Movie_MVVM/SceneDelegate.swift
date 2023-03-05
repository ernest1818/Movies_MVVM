// SceneDelegate.swift
// Copyright © Avagyan Ernest. All rights reserved.

import UIKit

/// SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    var coordinator: AppCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let assemblyBuilder = AssamblyBuilder()
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        coordinator = AppCoordinator(assemblyBuilder: assemblyBuilder)
        coordinator?.start()
    }
}
