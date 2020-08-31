//
//  Core.DescriptorContainer.swift
//  ResourceLibrary
//
//  Created by Илья Зимонин on 27.08.2020.
//  Copyright © 2020 Илья Зимонин. All rights reserved.
//

public extension Core {
	
	final class DescriptorContainer: NSObject {

		private var descriptors: [String: Descriptor] = [:]

		public func resolve<T, R: ResourceProtocol>(_ resourceType: R.Type) -> Descriptor? where R.T == T {
			let key = String(describing: resourceType)
			guard let anyDescriptor = descriptors[key] else {
				return nil
			}
			return anyDescriptor
		}

		public func put(descriptor: Descriptor) {
			let key = String(describing: descriptor.resourceClass)
			descriptors[key] = descriptor
		}

		func append(container: DescriptorContainer) {
			for (key, value) in container.descriptors {
				descriptors[key] = value
			}
		}

		func foreach(_ block: (Descriptor) throws -> Void) rethrows {
			try descriptors.forEach { (key: String, value: Core.Descriptor) in
				try block(value)
			}
		}
	}

}
