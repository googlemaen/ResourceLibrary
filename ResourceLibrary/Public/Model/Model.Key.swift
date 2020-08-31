//
//  Model.Key.swift
//  ResourceLibrary
//
//  Created by Илья Зимонин on 31.08.2020.
//  Copyright © 2020 Илья Зимонин. All rights reserved.
//

public extension Model {

	struct Key {

		var key: String

		var ext: String

		public init(key: String, ext: String) {
			self.key = key
			self.ext = ext
		}
	}
}
