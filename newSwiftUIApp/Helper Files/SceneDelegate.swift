//
//  SceneDelegate.swift
//  newSwiftUIApp
//
//  Created by Ido Shoshani on 1/3/20.
//  Copyright © 2020 Ido Shoshani. All rights reserved.
//

import UIKit
import SwiftUI
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    /*@Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
        entity: Assignment.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Assignment.dueDate, ascending: true),
        ]
    ) var assignments: FetchedResults<Assignment>*/

    var window: UIWindow?
    private(set) static var shared: SceneDelegate?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        Self.shared = self

        // Get the managed object context from the shared persistent container.
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Create the SwiftUI view and set the context as the value for the managedObjectContext environment keyPath.
        // Add `@Environment(\.managedObjectContext)` in the views that will need the context.
        let contentView = TestView().environment(\.managedObjectContext, context)
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: MotherView(viewRouter: ViewRouter()).environment(\.managedObjectContext, context))
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        //pdfStruct.updateNotifications(assignments)
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
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        //pdfStruct.updateNotifications(assignments)
    }
    
    // 1
    lazy var persistentContainer: NSPersistentContainer = {
      // 2
      let container = NSPersistentContainer(name: "Data")
      // 3
      container.loadPersistentStores { _, error in
        // 4
        if let error = error as NSError? {
          // You should add your own error handling code here.
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      }
      return container
    }()
    
    func saveContext() {
      // 1
      let context = persistentContainer.viewContext
      // 2
      if context.hasChanges {
        do {
          // 3
          try context.save()
        } catch {
          // 4
          // The context couldn't be saved.
          // You should add your own error handling here.
          let nserror = error as NSError
          fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
      }
    }


}

