//
//  CoronaClient.swift
//  Corona Widget
//
//  Created by Aaryan Kothari on 22/07/20.
//

import Foundation

private let url = URL(string: "https://api.covid19api.com/summary")

private var decoder: JSONDecoder{
    let decode = JSONDecoder()
    decode.keyDecodingStrategy = .convertFromSnakeCase
    return decode
}

class CoronaClient {
        class func fetchSummary(onSuccess: @escaping (Corona) -> Void){
            guard let url = url else { return }
    
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else{
                    fatalError(error!.localizedDescription)
                }
                do{
                    let coronaData = try decoder.decode(Corona.self, from: data)
                    DispatchQueue.main.async {
                        onSuccess(coronaData)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }.resume()
        }
}


