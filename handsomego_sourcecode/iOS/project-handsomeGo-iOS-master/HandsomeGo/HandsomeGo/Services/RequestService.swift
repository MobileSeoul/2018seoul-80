//
//  RequestService.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 23..
//  Copyright © 2018년 박세은. All rights reserved.
//

import Alamofire

protocol RequestService {
    associatedtype NetworkData: Codable
    func gettable(_ URL: String, body: [String:Any]?, header: HTTPHeaders?, completion: @escaping (NetworkResult<NetworkData>) -> Void)
    func postable(_ URL: String, body: [String:Any]?, header: HTTPHeaders?, completion: @escaping (NetworkResult<NetworkData>) -> Void)
}

extension RequestService {
    func gettable(_ URL: String, body: [String:Any]?, header: HTTPHeaders?, completion: @escaping (NetworkResult<NetworkData>) -> Void) {
        Alamofire.request(URL, method: .get, parameters: body, encoding: JSONEncoding.default, headers: header).responseData { (res) in
            
            guard let statusCode = res.response?.statusCode else {
                print("status")
                return
            }
            guard let status: HTTPStatusCode = HTTPStatusCode(rawValue: statusCode) else { return }
            switch status {
            case .OK:
                print("200")
                if let value = res.result.value {
                    
                    let decoder = JSONDecoder()
                    do {
                        let data = try decoder.decode(NetworkData.self, from: value)
                        completion(.success(data))
                    } catch {
                        print("decoding err")
                        completion(.error(423))
                    }
                }
            case .Accepted:
                print("203")
                completion(.successWithNil(203))
            case .BadRequest:
                print("400")
                completion(.error(400))
            case .Unauthorized:
                print("401")
                completion(.error(401))
            case .Forbidden:
                print("403")
                completion(.error(403))
            case .NotFound:
                print("404")
                completion(.error(404))
            case .Conflict:
                print("409")
                completion(.error(409))
            case .ValidationError:
                print("422")
                completion(.error(422))
            case .DecodingError:
                completion(.error(423))
            case .InternalServerError:
                print("500")
                completion(.error(500))
            }
        }
    }
    
    func postable(_ URL: String, body: [String:Any]?, header: HTTPHeaders?, completion: @escaping (NetworkResult<NetworkData>) -> Void) {
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseData { (res) in
            guard let statusCode = res.response?.statusCode else { return }
            guard let status: HTTPStatusCode = HTTPStatusCode(rawValue: statusCode) else { return }
            print(statusCode)
            switch status {
            case .OK:
                print("200")
                if let value = res.result.value {
                    let decoder = JSONDecoder()
                    do {
                        let data = try decoder.decode(NetworkData.self, from: value)
                        completion(.success(data))
                    } catch {
                        completion(.error(423))
                    }
                }
            case .Accepted:
                completion(.successWithNil(203))
            case .BadRequest:
                completion(.error(400))
            case .Unauthorized:
                print("401")
                completion(.error(401))
            case .Forbidden:
                print("403")
                completion(.error(403))
            case .NotFound:
                print("404")
                completion(.error(404))
            case .Conflict:
                print("409")
                completion(.error(409))
            case .ValidationError:
                print("422")
                completion(.error(422))
            case .DecodingError:
                completion(.error(423))
            case .InternalServerError:
                print("500")
                completion(.error(500))
            }
        }
    }
    
    func puttable(_ URL: String, body: [String:Any]?, header: HTTPHeaders?, completion: @escaping (NetworkResult<NetworkData>) -> Void) {
        Alamofire.request(URL, method: .put, parameters: body, encoding: JSONEncoding.default, headers: header).responseData { (res) in
            guard let statusCode = res.response?.statusCode else { return }
            guard let status: HTTPStatusCode = HTTPStatusCode(rawValue: statusCode) else { return }
            print(statusCode)
            switch status {
            case .OK:
                print("200")
                if let value = res.result.value {
                    let decoder = JSONDecoder()
                    do {
                        let data = try decoder.decode(NetworkData.self, from: value)
                        completion(.success(data))
                    } catch {
                        completion(.error(423))
                    }
                }
            case .Accepted:
                completion(.successWithNil(203))
            case .BadRequest:
                completion(.error(400))
            case .Unauthorized:
                print("401")
                completion(.error(401))
            case .Forbidden:
                print("403")
                completion(.error(403))
            case .NotFound:
                print("404")
                completion(.error(404))
            case .Conflict:
                print("409")
                completion(.error(409))
            case .ValidationError:
                print("422")
                completion(.error(422))
            case .DecodingError:
                completion(.error(423))
            case .InternalServerError:
                print("500")
                completion(.error(500))
            }
        }
    }
}

