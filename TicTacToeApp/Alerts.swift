//
//  Alerts.swift
//  TicTacToeApp
//
//  Created by Sothesom on 22/12/1402.
//
// آلارم ها

import SwiftUI

struct AlertsItem: Identifiable{
    let id = UUID()
    var title : Text
    var message: Text
    var buttomTitel: Text
}

struct AlertsContext{
    static let humenWin = AlertsItem(title: Text("You Win"),
                    message: Text("You are so smart"),
                    buttomTitel: Text("Hell yeah"))
    
    static let AIWin = AlertsItem(title: Text("You Lost"),
                    message: Text("You programmed a super AI"),
                    buttomTitel: Text("Rematch"))
    
    static let Drow = AlertsItem(title: Text("Drow"),
                    message: Text("What a battle of wits we have"),
                    buttomTitel: Text("Try agian"))
}
