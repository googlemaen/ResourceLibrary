//
//  FileSystem.ResourceService.swift
//  ResourceLibrary
//
//  Created by Илья Зимонин on 27.08.2020.
//  Copyright © 2020 Илья Зимонин. All rights reserved.
//

public extension FileSystem {

	final class ResourceService: NSObject {

		private let fileSystem: FileSystemProtocol
		private let directory: URL
		private let operationQueue: OperationQueue

		init(folderName: String, fileSystem: FileSystemProtocol, operationQueue: OperationQueue) throws {
			self.fileSystem = fileSystem
			let cachesUrl = try fileSystem.cachesDirectoryURL()
			directory = cachesUrl.appendingPathComponent(folderName)
			self.operationQueue = operationQueue
			super.init()
			try fileSystem.createDirectoryIfNeeded(directory)
		}

		func read<T, R: ResourceProtocol>(descriptor: Core.Descriptor, forKey key: Model.Key, completion: @escaping (R?) -> Void, completionQueue: DispatchQueue) where R.T == T {
			operationQueue.addOperation { [weak self] in
				guard let self = self else {
					return
				}
				let url = self.directory
					.appendingPathComponent(descriptor.folderName)
					.appendingPathComponent(key.key)
					.appendingPathExtension(key.ext)
				guard let data = self.fileSystem.getData(at: url) else {
					completionQueue.async {
						completion(nil)
					}
					return
				}
				completionQueue.async {
					completion(try? R(key: key, data: data))
				}
			}
		}

		func write<T, R: ResourceProtocol>(resource: R, with descriptor: Core.Descriptor) where R.T == T {
			operationQueue.addOperation { [weak self] in
				guard let self = self else {
					return
				}
				let url = self.directory
					.appendingPathComponent(descriptor.folderName)
					.appendingPathComponent(resource.key.key)
					.appendingPathExtension(resource.key.ext)
				guard let data = resource.data() else {
					return
				}
				self.fileSystem.save(data: data, at: url)
			}
		}

		func createDirectoryIfNeeded(_ directoryName: String) throws {
			let url = directory.appendingPathComponent(directoryName)
			try fileSystem.createDirectoryIfNeeded(url)
		}
	}

}
