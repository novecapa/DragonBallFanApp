//
//  NetworkClient.swift
//  DragonBallApp
//
//  Created by Josep Cerdá Penadés on 4/2/25.
//

import Foundation

final class NetworkClient {

    private let urlSession: URLSessionProtocol
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
}
// MARK: - NetworkClientProtocol
extension NetworkClient: NetworkClientProtocol {
    func call<T>(urlString: String,
                 method: NetworkMethod,
                 queryParams: [String: Any?]?,
                 of type: T.Type) async throws -> T where T: Decodable {

        var urlComponents = URLComponents(string: urlString)
        urlComponents?.addQueryParams(queryParams)

        guard let url = urlComponents?.url else {
            throw NetworkError.badURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()

        do {
            let (data, response) = try await urlSession.getDataFrom(request, type: T.self)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.badResponse
            }
            Log.thisRequest(response, data: data, request: request)
            switch response.statusCode {
            case 200..<300:
                return try JSONDecoder().decode(T.self, from: data)
            case 400:
                throw NetworkError.badRequest
            case 500:
                throw NetworkError.serverError
            case 502:
                throw NetworkError.badGateway
            default:
                throw NetworkError.badResponse
            }
        } catch {
            throw NetworkError.badRequest
        }
    }
}
