//
//  File.swift
//  
//
//  Created by Raymund Catahay on 2021-01-24.
//

import Foundation

public enum EndPointError: Error {
    case failedToCreateURL
    case neResponseFound
    case failedToMapResultModel
    case responseError(error: Error)
}

public typealias EndPointResult<ResultType: Codable> = Result<ResultType, EndPointError>

public typealias EndPointCompletion<ResultType: Codable> = (EndPointResult<ResultType>) -> ()

@available(OSX 10.13, *)
public extension EndPoint {
    
    @discardableResult
    func request<ResultType: Codable>(completion: @escaping EndPointCompletion<ResultType>) -> URLSessionDataTask? {
        
        func send(result: EndPointResult<ResultType>) {
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        guard let url = url else {
            send(result: .failure(.failedToCreateURL))
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.encodeHeaders(headers)
        if let urlParameter = urlParameter {
            urlRequest.encodeURLParameters(urlParameter)
        }
        if let body = body {
            urlRequest.encodeBodyParameters(body)
        }
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                send(result: .failure(.responseError(error: error)))
                return
            }
            guard response != nil, let data = data else {
                send(result: .failure(EndPointError.neResponseFound))
                return
            }
            if let responseObject = try? JSONDecoder().decode(ResultType.self, from: data) {
                send(result: .success(responseObject))
            } else {
                send(result: .failure(EndPointError.failedToMapResultModel))
            }
        }
        dataTask.resume()
        return dataTask
    }
}
