//
//  BaseResourceBuilder.swift
//  ResourceLibrary
//
//  Created by Илья Зимонин on 27.08.2020.
//  Copyright © 2020 Илья Зимонин. All rights reserved.
//

import UIKit

extension Core {

	final class ResourceBuilder: NSObject {

		static func createBaseContainer() -> DescriptorContainer {
			let container = DescriptorContainer()

			let imageDescriptor = Core.Descriptor(resourceClass: Model.Image.self, folderName: "Images")

			container.put(descriptor: imageDescriptor)

			return container
		}
	}

}
