//
//  GameViewModel.swift
//  TicTacToeApp
//
//  Created by Sothesom on 22/12/1402.
//

import SwiftUI

final class GameViewModel: ObservableObject{
    
    let columns : [GridItem] = [GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible()) ]
    
    // مقدار دهی اولیه
        @Published var move: [Move?] = Array(repeating: nil, count: 9)
    // میخوام وقتی انسان ضربه زد برد تا وقتی نوبت انسان میشه خیر فعال بشه
        @Published var isGameboardDisabled = false
        
        @Published var alertItem: AlertsItem?
    
    func processPlayerMove(for i: Int){
        
// اکر مربع اشغال شده ای را ضربه زدیم چیزی رو ریترن نکنه
            if isSquareOccupied(in: move, forIndex: i) {return}
            move[i] = Move(player: .Human, boardIndex: i)
           
            // check for win condition
            if checkWinCondition(for: .Human, in: move){
                alertItem = AlertsContext.humenWin
                return
            }
            // or draw
            if checkForDraw(in: move){
                alertItem = AlertsContext.Drow
                return
            }
            isGameboardDisabled = true
// میخوام وقتی انسان ضربه زد برد تا وقتی نوبت انسان میشه خیر فعال بشه

            
// حرکت کامپیوتر با تاخیر
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                let computerPosition = determineComputerMovePosition(in: move)
                    move[computerPosition] = Move(player: .AI, boardIndex: computerPosition )
                isGameboardDisabled = false

                if checkWinCondition(for: .AI, in: move){
                    alertItem = AlertsContext.AIWin
                    return
                }
                if checkForDraw(in: move){
                    alertItem = AlertsContext.Drow
                    return
                }
            }
        
    }
    
    
// تابع فضای اشغال شده
    func isSquareOccupied(in move:[Move?], forIndex index: Int) -> Bool{
        return move.contains(where:{ $0?.boardIndex == index })
    }
    
    
// حرکت کامپیوتر
//   If AI can't take middle square,take random available square
    func determineComputerMovePosition(in move:[Move?]) -> Int{
        
//   If AI can win, then win
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0,3,6], [1, 4,7], [2, 5, 8],[0, 4, 8],[2,4,6]]
        
        let AIMove = move.compactMap{$0}.filter{$0.player == .AI}
        let AIPositions = Set(AIMove.map{$0.boardIndex})
        
        for pattern in winPatterns {
// مجموعه ای از موفقیت ها رو به من میده
            let winPositions = pattern.subtracting(AIPositions)
            if winPositions.count == 1 {
// outpot Bool:
                let isAvaiable = !isSquareOccupied(in: move, forIndex: winPositions.first!)
                
                if isAvaiable {return winPositions.first!}
            }
        }
        
//   If AI can't win,then block
        let HumanMove = move.compactMap{$0}.filter{$0.player == .Human}
        let HumanPositions = Set(HumanMove.map{$0.boardIndex})
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(HumanPositions)
            
            if winPositions.count == 1 {
                let isAvaiable = !isSquareOccupied(in: move, forIndex: winPositions.first!)
                if isAvaiable {return winPositions.first!}
            }
        }
        
//   If AI can't block,then take middle square
        if !isSquareOccupied(in: move, forIndex: 4){
            return 4
        }
        
        
// موقعیت حرکت
        var movePosition = Int.random(in: 0..<9)
        
// الان یه موقعیت داریم ولی باید بسنجیم که تون موقعیت اشغال نشده باشه
// if  دستور مناسبی نیست چون یک بار فقط چک میکنه پس بجای اون از while  استفاده میکنیم
        
        while isSquareOccupied(in: move, forIndex: movePosition){
            movePosition = Int.random(in: 0..<9)
// در این حالت اگر فالس بود از حلقه خارج میشه و موقعیت درست رو به ما میده
        }
        return movePosition
    }
    
    
// check for win condition
    func checkWinCondition(for Player: Player, in move: [Move?]) -> Bool{
// شرایط برد
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0,3,6], [1, 4,7], [2, 5, 8],[0, 4, 8],[2,4,6]]

// حرکت بازیکن >>> حذف تمام صفر ها >>> فیلتر کردن هر بازی کن
        let playerMove = move.compactMap{$0}.filter{$0.player == Player}
// حرکت هر بازیکن رو مرور کن بعد همه فهرست صفحه رو به من بده
        let playerPositions = Set(playerMove.map{$0.boardIndex})
// بررسی کردن شرایط برد
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) {return true}
// در غیر این صورت
        return false
    }
    
// or draw
    func checkForDraw(in move: [Move?]) -> Bool {
        return move.compactMap{$0}.count == 9
    }
    
// reset Game
    func resetGame(){
        move = Array(repeating: nil, count: 9)
    }
}
