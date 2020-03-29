//
//  File.swift
//  
//
//  Created by everis on 3/28/20.
//

import Foundation

class Interactor {
    private let urlSession = URLSession.shared
    func call<Input: Encodable, Output: Decodable>
        (_ method: HttpMethod,
         _ urlPath: String,
         sending content: Input?,
         onCompletion: @escaping CompletionHandler<Output>) -> Cancelable
    {
        var urlRequest = URLRequest(url: URL(TODOfrom: urlPath))
        urlRequest.httpMethod = method.rawValue
        if let content = content,
            let contentData = try? JSONEncoder().encode(content)
        {
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = contentData
        } // Ignore this error for now
        
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                onCompletion(.failure(error))
            }
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200,
                let data = data
                else
            {
                onCompletion(.failure(TodoError.invalidResponse))
                return
            }
            
            if let obj = try? JSONDecoder().decode(Output.self, from: data) {
                onCompletion(.success(obj))
            } else {
                onCompletion(.failure(TodoError.invalidResponse))
            }
        }
        task.resume()
        return task
    }
    
    func call<Output: Decodable>
        (_ method: HttpMethod,
         _ urlPath: String,
         onCompletion: @escaping CompletionHandler<Output>) -> Cancelable {
        let dummyEncodable: String? = nil
        return self.call(method, urlPath,
                  sending: dummyEncodable,
                  onCompletion: onCompletion)
    }
}

func intoNative(from data: Data) -> Any? {
    try? JSONSerialization.jsonObject(with: data, options: [])
}

func intoString(from data: Data, simplify: Bool = true) -> String? {
    var result = String(data: data, encoding: .utf8)
    if simplify, let ogString = result {
        result = String(ogString.unicodeScalars.filter {
            !CharacterSet.newlines.contains($0)
        })
    }
    return result
}

func intoCodable<T: Decodable>(from data: Data, type: T.Type) -> T? {
    try? JSONDecoder().decode(type, from: data)
}
