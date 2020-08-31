//
//  FileSystem.FileSystem.swift
//  ResourceLibrary
//
//  Created by Илья Зимонин on 27.08.2020.
//  Copyright © 2020 Илья Зимонин. All rights reserved.
//

import Foundation

extension FileSystem {

	final class FileSystem: NSObject, FileSystemProtocol {

		func cachesDirectoryURL() throws -> URL {
			let fm = FileManager.default
			return try fm.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
		}

		func createDirectoryIfNeeded(_ path: URL) throws {
			let fm = FileManager.default
			try fm.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
		}

		func save(data: Data, at path: URL) {
			try? data.write(to: path, options: .atomic)
		}

		func getData(at path: URL) -> Data? {
			return try? Data(contentsOf: path, options: [])
		}
	}
}
