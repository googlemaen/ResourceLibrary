//
//  Model.Image.swift
//  ResourceLibrary
//
//  Created by Илья Зимонин on 27.08.2020.
//  Copyright © 2020 Илья Зимонин. All rights reserved.
//

import UIKit

public extension Model {

	final class Image: ResourceProtocol {

		public let key: Key
		public let value: UIImage

		public init(key: Key, value: UIImage) {
			self.key = key
			self.value = value
		}

		public init(key: Key, data: Data) throws {
			self.key = key
			guard let image = UIImage(data: data) else {
				throw Model.Error.mapError(resourceName: "UIImage")
			}
			self.value = image
		}

		public func data() -> Data? {
			return value.pngData()
		}
	}
}
