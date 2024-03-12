//
//  TicTacToeAppApp.swift
//  TicTacToeApp
//
//  Created by Sothesom on 21/12/1402.
//

import SwiftUI
import TipKit

@main
struct TicTacToeAppApp: App {
    var body: some Scene {
        WindowGroup {
            GameView()
                .task {
                    try? Tips.resetDatastore()
                    // مکان ذخیره سازی داده
                    try? Tips.configure([.displayFrequency(.immediate), .datastoreLocation(.applicationDefault)])
                }
        }
    }
}
