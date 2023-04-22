//
//  ChatBubble.swift
//  Chat
//
//  Created by chantil on 2023/4/22.
//

import SwiftUI

struct ChatBubble: View {
    var message: String
    var isMe: Bool

    var body: some View {
        HStack {
            if !isMe {
                Image(systemName: "person.fill")
            }
            Text(message)
                .padding(10)
                .foregroundColor(.white)
                .background(isMe ? Color.blue : Color.gray)
                .cornerRadius(10)
            if isMe {
                Image(systemName: "person.fill")
            }
        }
    }
}

struct ChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        ChatBubble(message: "Hello, World!", isMe: true)
    }
}
