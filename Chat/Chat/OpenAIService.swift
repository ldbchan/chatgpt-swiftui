//
//  OpenAIService.swift
//  Chat
//
//  Created by chantil on 2023/4/22.
//

import Foundation

class OpenAIService {
    let apiKey = "YOUR_API_KEY"
    let url = URL(string: "https://api.openai.com/v1/chat/completions")!

    func generateResponse(
        prompt: String,
        completionHandler: @escaping (String?, Error?) -> Void
    ) {
        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        let parameters: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "user", "content": prompt]
            ]
        ]
        request.httpBody = try? JSONSerialization.data(
            withJSONObject: parameters,
            options: []
        )

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, error)
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                if let choices = json?["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    completionHandler(content, nil)
                } else {
                    completionHandler(nil, error)
                }
            } catch {
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
}
