//
//  ProjectDay60App.swift
//  ProjectDay60
//
//  Created by Rodrigo on 10-08-24.
//
import SwiftData
import SwiftUI

@main
struct ProjectDay60App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
