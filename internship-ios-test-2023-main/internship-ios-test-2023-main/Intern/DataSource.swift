//
//  DataSource.swift
//  Intern
//
//  Created by Zoltan Vinkler on 23/05/2023.
//

import Foundation

class DataSource: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var errorMessage: String = ""

    init() {
        decodeJSONFile(filename: "Movies", type: [Movie].self) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }
}

enum MyError: Error, LocalizedError {
    case fileNotFound

    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return NSLocalizedString("JSON file not found", comment: "File not found error")
        }
    }
}

func decodeJSONFile<T: Decodable>(filename: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
    guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
        completion(.failure(MyError.fileNotFound))
        return
    }
    do {
        let data = try Data(contentsOf: url)
        let object = try JSONDecoder().decode(type, from: data)
        completion(.success(object))
    } catch {
        completion(.failure(error))
    }
}
