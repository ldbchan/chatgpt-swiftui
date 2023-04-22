//
//  ContentView.swift
//  Chat
//
//  Created by chantil on 2023/4/22.
//

import SwiftUI

struct ContentView: View {
    @State var messages: [String] = []
    @State var newMessage = ""
    let openAIService = OpenAIService()

    var body: some View {
        VStack {
            ScrollView {
                ForEach(messages.indices, id: \.self) { index in
                    ChatBubble(message: messages[index], isMe: index % 2 == 0)
                }
            }
            HStack {
                TextField("Type your message", text: $newMessage)
                Button("Send") {
                    messages.append(newMessage)
                    openAIService.generateResponse(prompt: newMessage) { response, error in
                        DispatchQueue.main.async {
                            if let response = response {
                                messages.append(response)
                            } else {
                                messages.append(
                                    "Error: \(error?.localizedDescription ?? "Unknown")"
                                )
                            }
                        }
                    }
                    newMessage = ""
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
