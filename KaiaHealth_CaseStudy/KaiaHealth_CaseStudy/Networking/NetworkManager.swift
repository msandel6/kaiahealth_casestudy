//
//  NetworkManager.swift
//  KaiaHealth_CaseStudy
//
//  Created by Muriel Sandel on 8/22/21.
//

import UIKit

final class NetworkManager {

    // MARK: Singleton

    static let shared = NetworkManager()

    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy =  .convertFromSnakeCase
        return decoder
    }()

    // MARK: Perform GET requests

    func performRequest<T: Codable>(for returnType: T.Type, with url: URL, completion: @escaping ((Result<T, Error>) -> Void)) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            guard error == nil,
                  let response = response,
                  response.isStatusValid,
                  let data = data else {
                completion(.failure(NetworkingError.invalidResponse))
                return
            }

            do {
                let decodedData = try Self.decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NetworkingError.invalidResponse))
            }
        }

        task.resume()
    }

    // MARK: Load image resources

    func loadImage(_ url: URL, _ completion: @escaping ((UIImage?) -> Void)) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                completion(image)
            } catch {
                completion(nil)
            }
        }
    }
}
