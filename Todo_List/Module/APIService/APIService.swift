//
//  APIService.swift
//  Todo_List
//
//  Created by Huzaifa on 05/09/2025.
//

import Foundation

class APIService {
    
    static let shared = APIService()
    private let baseURL = URL(string: "http://localhost:8000/api")!
    private let session = URLSession.shared
    
    // MARK: - Fetch Items
    
    func fetchItems(completion: @escaping (Result<[ItemModel], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("items")
        performRequest(url: url, method: "GET", completion: completion)
    }

    // MARK: - Add Item
    
    func addItem(_ item: ItemModel, completion: @escaping (Result<ItemModel, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("items")
        performRequest(
            url: url,
            method: "POST",
            body: item,
            completion: completion
        )
    }

    // MARK: - Update Item
    
    func updateItem(_ item: ItemModel, completion: @escaping (Result<ItemModel, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("items/\(item.id)")
        performRequest(
            url: url,
            method: "PUT",
            body: item,
            completion: completion
        )
    }

    // MARK: - Delete Item
    
    func deleteItem(_ id: String, completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathComponent("items/\(id)")
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        session.dataTask(with: request) { _, _, error in
            completion(error)
        }.resume()
    }

    // MARK: - Generic Request Method
    
    private func performRequest<T: Codable>(
        url: URL,
        method: String,
        body: T? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                completion(.failure(error))
                return
            }
        }
        
        session.dataTask(with: request) { data, _, error in
            if let error = error {
                return completion(.failure(error))
            }
            guard let data = data else {
                return completion(.failure(APIError.noData))
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

// MARK: - API Error Enum

enum APIError: LocalizedError {
    case noData

    var errorDescription: String? {
        switch self {
        case .noData:
            return "No data received from the server."
        }
    }
}
