//
//  ResourceProtocol.swift
//  ResourceLibrary
//
//  Created by Илья Зимонин on 27.08.2020.
//  Copyright © 2020 Илья Зимонин. All rights reserved.
//

public protocol ResourceProtocol {

	associatedtype T

	var key: Model.Key { get }

	var value: T { get }

	init(key: Model.Key, value: T)

	init(key: Model.Key, data: Data) throws

	func data() -> Data?
}
