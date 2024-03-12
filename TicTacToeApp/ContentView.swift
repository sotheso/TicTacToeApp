//
//  ContentView.swift
//  TicTacToeApp
//
//  Created by Sothesom on 21/12/1402.
//

import SwiftUI

struct ContentView: View {
    
    let columns : [GridItem] = [GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible()) ]
// مقدار دهی اولیه
    @State private var move: [Move?] = Array(repeating: nil, count: 9)
// قابلیت ضربه زدن
    @State private var isHumanTurn = true
    
    
    var body: some View {
        
        GeometryReader{ geo in
            VStack{
                Spacer()
                 
                LazyVGrid(columns: columns, spacing: 5){
                    ForEach(0..<9){ i in
                        ZStack{
                            Circle()
                                .foregroundColor(.secondary).opacity(0.8)
                                .frame(width: geo.size.width/3 - 15, height: geo.size.width/3 - 15)
// نشانگر
                            Image(systemName: move[i]?.indicator ?? "")
                                .resizable()
                                .frame(width: 40 , height: 40)
                                .foregroundColor(.primary)
                        }
                        .onTapGesture {
                            // اکر مربع اشغال شده ای را ضربه زدیم چیزی رو ریترن نکنه
                            if isSquareOccupied(in: move, forIndex: i) {return}
                            
                            move[i] = Move(player: isHumanTurn ? .Human : .AI, boardIndex: i)
// یعنی اینجا نوبت کامپیوتر است
                            isHumanTurn.toggle()
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
         }
    }
    
    
// تابع فضای اشغال شده
    func isSquareOccupied(in move:[Move?], forIndex index: Int) -> Bool{
        return move.contains(where:{ $0?.boardIndex == index })
    }

// حرکت کامپیوتر
    func determineComputerMovePosition(in move:[Move?]) -> Int{
// موقعیت حرکت
        var movePosition = Int.random(in: 0..<9)
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
    ContentView()
}
