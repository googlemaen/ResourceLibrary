//
//  ViewController.swift
//  ResourceExample
//
//  Created by Илья Зимонин on 27.08.2020.
//  Copyright © 2020 Илья Зимонин. All rights reserved.
//

import UIKit
import ResourceLibrary

class ViewController: UIViewController {

	private var library: Core.Library! = nil

	private let errorLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 16.0)
		label.text = "Ошибка загрузки изображения"
		return label
	}()

	private let imageView = UIImageView()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()

		do {
			self.library = try Core.Library.createDefault()
			let key = Model.Key(key: "asd", ext: "png")
			let imageResource = Model.Image(key: key, value: drawImage())
			library.write(imageResource)
			DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
				self.readImage(key: key)
			}
		} catch (let error) {
			print(error)
		}
	}

	func setupViews() {
		view.addSubview(errorLabel)
		view.addSubview(imageView)
		errorLabel.isHidden = true
		imageView.isHidden = true
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		errorLabel.frame = CGRect(x: 0.0, y: 100.0, width: view.bounds.width, height: 40.0)
		let imageViewFrame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
		imageView.frame = imageViewFrame
		imageView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
	}

	func readImage(key: Model.Key) {
		library.read(Model.Image.self, forKey: key) { imageResource in
			guard let resource = imageResource else {
				self.errorLabel.isHidden = false
				return
			}
			self.imageView.image = resource.value
			self.imageView.isHidden = false
		}
	}

	func drawImage() -> UIImage {
		let renderer = UIGraphicsImageRenderer(size: CGSize(width: 100.0, height: 100.0))
		let image = renderer.image { context in
			let cgContext = context.cgContext
			cgContext.setFillColor(UIColor.red.cgColor)
			cgContext.fill(CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
			cgContext.setFillColor(UIColor.green.cgColor)
			cgContext.fill(CGRect(x: 40.0, y: 40.0, width: 20.0, height: 20.0))
		}
		return image
	}
}

