//
//  Log.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 4/2/25.
//

import Foundation

final class Log {

    static func thisRequest(_ response: HTTPURLResponse, data: Data, request: URLRequest?) {
        let code = response.statusCode
        let url  = response.url?.absoluteString ?? ""
        let icon  = [200, 201, 204].contains(code) ? "✅" : "❌"
        print("------------------------------------------")
        print("\(icon) 🔽 [\(code)] \(url)")
        print("\(data.prettyPrintedJSONString ?? "")")
        print("\(icon) 🔼 [\(code)] \(url)")
        print("------------------------------------------")
    }
}
extension Data {
    var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object,
                                                     options: [.withoutEscapingSlashes]),
              let prettyPrintedString = String(data: data,
                                               encoding: .utf8) else { return nil }
        return prettyPrintedString
    }
}
extension URLRequest {
    public func curl(pretty: Bool = false) -> String {
        var data: String = ""
        let complement = pretty ? "\\\n" : ""
        let method = "-X \(self.httpMethod ?? "GET") \(complement)"
        var urlStringPath = ""
        if let urlString = self.url?.absoluteString {
            urlStringPath = urlString
        }
        let url = "\"" + urlStringPath + "\""
        var header = ""
        if let httpHeaders = self.allHTTPHeaderFields, httpHeaders.keys.count > 0 {
            for (key, value) in httpHeaders {
                header += "-H \"\(key): \(value)\" \(complement)"
            }
        }
        if let bodyData = self.httpBody,
           let bodyString = String(data: bodyData, encoding: .utf8) {
            data = "-d \"\(bodyString)\" \(complement)"
        }
        let command = "curl -i " + complement + method + header + data + url
        return command
    }
}
