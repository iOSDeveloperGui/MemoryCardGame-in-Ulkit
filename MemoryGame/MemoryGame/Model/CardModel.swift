//
//  CardModel.swift
//  MemoryGame
//
//  Created by iOS Developer on 04/04/25.
//

import Foundation

struct CardModel: Identifiable, Equatable{
    let id: UUID
    let identifier: String
    var isFlipped: Bool
    var isMatched: Bool
    
    init(identifier: String){
        self.id = UUID()
        self.identifier = identifier
        self.isFlipped = false
        self.isMatched = false
    }
}
