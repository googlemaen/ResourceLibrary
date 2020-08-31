//
//  TestResource.swift
//  ResourceLibraryTests
//
//  Created by Илья Зимонин on 01.09.2020.
//  Copyright © 2020 Илья Зимонин. All rights reserved.
//

import ResourceLibrary

final class TestResource: ResourceProtocol {

	let value: Int

	let key: Model.Key

	init(key: Model.Key, data: Data) throws {
		throw Model.Error.mapError(resourceName: "TestResource")
	}

	init(key: Model.Key, value: Int) {
		self.key = key
		self.value = value
	}

	func data() -> Data? {
		return nil
	}
}
