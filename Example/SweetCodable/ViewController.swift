//
//  ViewController.swift
//  SweetCodable
//
//  Created by jowsing on 04/11/2024.
//  Copyright (c) 2024 jowsing. All rights reserved.
//

import UIKit
import SweetCodable

class ViewController: UIViewController {
    
    struct User: Codable {
        @Sweet var name: String
        @Sweet var age: Int
        @Sweet var sex: Int8
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let user: User? = ["name": 0.1, "age": "18", "sex": "1"].toModel()
        print(user)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

extension Dictionary where Key == String, Value == Any {
    
    func toData() -> Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted, .fragmentsAllowed])
    }
    
    func toModel<T>() -> T? where T: Codable {
        guard let data = toData() else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
