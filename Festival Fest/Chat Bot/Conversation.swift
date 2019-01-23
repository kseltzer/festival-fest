//
//  Conversation.swift
//  Festival Fest
//
//  Created by Kimberly Seltzer on 1/22/19.
//  Copyright © 2019 Festival Fest. All rights reserved.
//

import Foundation

class Conversation {
    // List of Messages in the conversation
    var messages = [Message]()
    
    // Add welcoming text to open the conversation
    init() {
        messages.append(Message(date: Date(), text: "Welcome to the AI Tent! My name is Art and I'm a psychotherapist chatbot but I'm also a total psycho haha", type: .answer))
    }
    
    // Add a new question to the conversation
    func add(question: String) {
        messages.append(Message(date: Date(), text: question, type: .question))
    }
    
    // Add a new answer to the conversation
    func add(answer: String) {
        messages.append(Message(date: Date(), text: answer, type: .answer))
    }
}
