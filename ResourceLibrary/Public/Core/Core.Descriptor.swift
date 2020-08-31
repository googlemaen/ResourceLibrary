//
//  Core.Descriptor.swift
//  ResourceLibrary
//
//  Created by Илья Зимонин on 27.08.2020.
//  Copyright © 2020 Илья Зимонин. All rights reserved.
//

public extension Core {

	final class Descriptor: NSObject {

		let folderName: String
		let resourceClass: AnyClass

		public init<T, R: ResourceProtocol>(resourceClass: R.Type, folderName: String) where R.T == T {
			self.resourceClass = resourceClass as! AnyClass
			self.folderName = folderName
		}
	}

}
