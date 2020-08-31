//
//  Model.Error.swift
//  ResourceLibrary
//
//  Created by Илья Зимонин on 28.08.2020.
//  Copyright © 2020 Илья Зимонин. All rights reserved.
//

public extension Model {

	enum Error: Swift.Error {
		case mapError(resourceName: String)
	}
}
