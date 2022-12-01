//
//  Service.swift
//  Ultimate Pokedex
//
//  Created by Ali Eldeeb on 11/30/22.
//

import Foundation

class Service{
    static let shared = Service()
    private let session = URLSession(configuration: .default)
    private var images = NSCache<NSString, NSData>()
    
    func fetchPokeData(completion: @escaping ([Pokemon]) -> ()){
        guard let url = URL(string: "https://pokedex-bb36f.firebaseio.com/pokemon.json") else{ return }
        session.dataTask(with: url) { data, response, error in
            guard error == nil else{ fatalError("\(error!.localizedDescription)") }
            
            guard let response = response as? HTTPURLResponse else{ return }
            guard(200...299).contains(response.statusCode) else{
                fatalError("Recieved improper server response: \(response.statusCode)")
            }
            
            guard let data = data?.parseData(from: "null,") else{ return }
            let decoder = JSONDecoder()
            if let pokeData = try? decoder.decode([Pokemon].self, from: data){
                completion(pokeData)
            }
        }.resume()
    }
    
    func fetchImage(pokemon: Pokemon, completion: @escaping (Data?, Error?) -> ()){
        guard let url = URL(string: pokemon.imageUrl) else { return }
        if let imageData = images.object(forKey: url.absoluteString as NSString){
            completion(imageData as Data, nil)
            return
        }
        session.downloadTask(with: url) { localUrl, response, error in
            guard error == nil else{ fatalError(error!.localizedDescription) }
            guard let response = response as? HTTPURLResponse else{ return }
            guard(200...299).contains(response.statusCode) else{
                assertionFailure("Recieved improper response: \(response.statusCode)")
                return
            }
            
            guard let localUrl = localUrl else{
                completion(nil, error)
                return
            }
            do{
                let safeData = try Data(contentsOf: localUrl)
                self.images.setObject(safeData as NSData, forKey: url.absoluteString as NSString)
                completion(safeData, nil)
            }catch let error{
                print(error)
            }
            
        }.resume()
    }
}

extension Data{
    func parseData(from string: String) -> Data?{
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else{ return nil}
        return data
    }
}

