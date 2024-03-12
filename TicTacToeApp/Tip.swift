//
//  Tip.swift
//  TicTacToeApp
//
//  Created by Sothesom on 22/12/1402.
//

import Foundation
import TipKit

struct StartGameTip: Tip{
    var title: Text{
        Text("Start the game!")
        
    }
    var message: Text? {
         Text("The game starts with you.Choose one of the houses")
    }
    
    var image: Image?{
        Image(systemName: "gamecontroller")
    }
}

struct SetTipMent: Tip{
    var title: Text{
        Text("Start the game!")
    }
    
    var message: Text?{
        Text("You can play with the robot by choosing a place")
    } 
    
    var image: Image?{
        Image(systemName: "gamecontroller")
    }
}
