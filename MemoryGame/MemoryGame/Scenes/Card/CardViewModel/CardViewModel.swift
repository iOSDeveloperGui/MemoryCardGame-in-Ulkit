//
//  CardViewModel.swift
//  MemoryGame
//
//  Created by iOS Developer on 04/04/25.
//

import Foundation

final class CardViewModel{
    
    //MARK: - Referencies, array, variables & properties
    public var cards: [CardModel] = []
    private var firstFlippedIndex: Int?
    private var isProcessing = false
    private var timer: Timer?
    private var secondsElapsed: Int = 0
    var didUpdateCards: (() -> Void)?
    var didUpdateTimer: ((String) -> Void)?
    var didMatchCard: (() -> Void)?
    
    //MARK: - Initializer
    init(){
        loadCards()
    }
    
    //MARK: - LoadCardsMethod
    private func loadCards(){
        let identifiers = ["cat1", "cat2", "cat3", "cat4", "cat5", "cat6", "cat7", "cat8"]
        let duplicated = identifiers + identifiers
        let shuffled = duplicated.shuffled()
        
        self.cards = shuffled.map { CardModel(identifier: $0)}
    }
    
    //MARK: - CardsMethod
    func card(at index: Int) -> CardModel{
        return cards[index]
    }
    
    var numberOfCards: Int{
        return cards.count
    }
    
    //MARK: - FlipCardMethod
    public func flipCard(at index: Int){
        guard !cards[index].isFlipped,
              !cards[index].isMatched,
              !isProcessing else { return }
        
        cards[index].isFlipped = true
        
        if let firsIndex = firstFlippedIndex{
            isProcessing = true
            checkForMatch(firstIndex: firsIndex, secondIndex: index)
            firstFlippedIndex = nil
        } else{
            firstFlippedIndex = index
        }
        didUpdateCards?()
    }
    
    //MARK: - CheckForMatchMethod
    private func checkForMatch(firstIndex: Int, secondIndex: Int){
        let firstCard = cards[firstIndex]
        let secondCard = cards[secondIndex]
        
        if firstCard.identifier == secondCard.identifier{
            cards[firstIndex].isMatched = true
            cards[secondIndex].isMatched = true
            didMatchCard?()
            isProcessing = false
        } else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
                self.cards[firstIndex].isFlipped = false
                self.cards[secondIndex].isFlipped = false
                self.isProcessing = false
                self.didUpdateCards?()
            }
        }
    }
    
    //MARK: - StartTimerMethod
    public func startTimer(){
        secondsElapsed = 0
        didUpdateTimer?(formatTime(secondsElapsed))
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.secondsElapsed += 1
            self.didUpdateTimer?(self.formatTime(self.secondsElapsed))
            
            if self.cards.allSatisfy({ $0.isMatched }){
                self.timer?.invalidate()
            }
        }
    }
    
    //MARK: - StopTimerMethod
    private func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    //MARK: - ResetTimerMethod
    private func resetTimer(){
        stopTimer()
        secondsElapsed = 0
        didUpdateTimer?(formatTime(secondsElapsed))
    }
    
    //MARK: - FormatTimeMethod
    private func formatTime(_ seconds: Int) -> String{
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}

