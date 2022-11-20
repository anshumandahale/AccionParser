import Foundation

/// These are the errors this class might return
public enum ManagerErrors: Error {
    case invalidResponse
    case invalidStatusCode(Int)
}

/// This is our network class, it will handle all our requests
class NetworkManager {
    /// Performs the request and gets the data
    /// - Parameters:
    ///   - request: URLRequest
    ///   - completion: Complition handler
    func performRequest<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }

        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completionOnMain(.failure(error))
                return
            }
            // Check for success response code. Else return failure
            guard let urlResponse = response as? HTTPURLResponse else { return completionOnMain(.failure(ManagerErrors.invalidResponse)) }
            if !(200..<300).contains(urlResponse.statusCode) {
                return completionOnMain(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
            }
            
            guard let data = data else { return }
            do {
                let users = try JSONDecoder().decode(T.self, from: data)
                completionOnMain(.success(users))
            } catch {
                completionOnMain(.failure(error))
            }
        }
        urlSession.resume()
    }
}
