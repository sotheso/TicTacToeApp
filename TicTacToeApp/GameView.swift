//
//  ContentView.swift
//  TicTacToeApp
//
//  Created by Sothesom on 21/12/1402.
//

import SwiftUI

struct GameView: View {
    @StateObject private var VM = GameViewModel()
    
    var body: some View {
        GeometryReader{ geo in
            VStack{
                Spacer()
                LazyVGrid(columns: VM.columns, spacing: 5){
                    ForEach(0..<9){ i in
                        ZStack{
                            GameSquareView(prowy: geo)
                            PlayerIndicator(systemImageName:  VM.move[i]?.indicator ?? "")
                        }
                        .onTapGesture {
                            VM.processPlayerMove(for: i)
                        }
                    }
                }
                Spacer()
            }
            .padding()
            .disabled(VM.isGameboardDisabled)
            .alert(item: $VM.alertItem, content: {item in
                Alert(title: item.title, message: item.message, dismissButton: .default(item.buttomTitel, action: {VM.resetGame() }))
            })
         }
    }
}


enum Player{
    case Human, AI
}

struct Move{
    // چه بازیکنی حرکت را در کجای تخته انجام داده
    let player : Player
    let boardIndex: Int
    
    // نشانگر
    var indicator: String{
        return player == .Human ? "xmark" : "circle"
    }
}

#Preview {
    GameView()
}

struct GameSquareView: View {
    var prowy : GeometryProxy
    var body: some View {
        Circle()
            .foregroundColor(.secondary).opacity(0.8)
            .frame(width: prowy.size.width/3 - 15, height: prowy.size.width/3 - 15)
    }
}

struct PlayerIndicator : View {
    var systemImageName : String
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40 , height: 40)
            .foregroundColor(.primary)
    }
}
