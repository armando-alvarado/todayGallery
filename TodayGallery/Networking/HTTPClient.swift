//
//  HTTPClient.swift
//  TodayGallery
//
//  Created by Armando Antonio Alvarado Torres on 08/03/21.
//

import Foundation

enum HTTPMethod: String, CaseIterable {
    case post = "POST"
    case get = "GET"
}

protocol HTTPRequest {
    associatedtype Response: Codable

    var urlPath: String { get }
    var method: HTTPMethod { get }
}


enum HTTPError: Error {
    case parsing
    case genericError(message: String)

    var localizedDescription: String {
        switch self {
        case .parsing:
            return "An error has ocurred during response parsing"
        case .genericError(let error):
            return error
        }
    }
}

class HTTPClient {
    private let urlSession: URLSession
    private var baseURL: String

    init(baseURL: String, urlSession: URLSession) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }

    func request<Request: HTTPRequest>(request: Request, completion: @escaping (Result<Request.Response, HTTPError>) -> ()) {
        do {
            let urlRequest = try createURLRequest(for: request)

            let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in

                if let err = error {
                    DispatchQueue.main.async {
                        completion(.failure(.genericError(message: err.localizedDescription)))
                        print(err.localizedDescription)
                    }
                    return
                }
                guard response != nil, let data = data else {
                    DispatchQueue.main.async {
                        completion(.failure(.genericError(message: "request error")))
                    }
                    return
                }

                self.decodeResponse(request: request, data: data) { response in
                    DispatchQueue.main.async {
                        switch response {
                        case .success(let responseObject):
                            completion(.success(responseObject))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                }
            }
            dataTask.resume()
        } catch let error as HTTPError {
            completion(.failure(error))
        } catch {
            completion(.failure(.genericError(message: error.localizedDescription)))
        }
    }

}

extension HTTPClient {

    private func createURLRequest<Request: HTTPRequest>(for request: Request) throws -> URLRequest {
        guard let url = URL(string: baseURL + request.urlPath) else {
            throw HTTPError.genericError(message: "bad URL format")
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue

        return urlRequest
    }

    private func decodeResponse<Request: HTTPRequest>(request: Request, data: Data, completion: @escaping (Result<Request.Response, HTTPError>) -> ()) {
        do {
            let responseObject = try JSONDecoder().decode(Request.Response.self, from: data)
            completion(.success(responseObject))
        } catch {
            completion(.failure(.parsing))
        }
    }
}
