//
//  Start.swift
//  PhysicsGame
//
//  Created by Maximilian Hünenberger on 7.8.16.
//  Copyright © 2016 MaHue. All rights reserved.
//

import Foundation

let pathToWorkingDirectory = "/Users/Maxi/Documents/Developer/PhysicsGameLinux"

var item = Item(position: Point(x: 20, y: 100))

func setup() {



/*


	var texture = Texture()
	texture.append(.color(Color(red: 0, green: 1, blue: 0, alpha: 1)))
	texture.append(.rectangle(Rectangle(0, 0, 100, 200)))

	item.texture = texture
	item.setPhysicsBody(relativePosition: Point(x: 0, y: 0),
	                    size: Size(100, 200),
	                    mass: 1,
	                    friction: 1)

	let block = Block(position: Point(x: 0, y: 10),
	                  size: Size(300, 10),
	                  color: Color(red: 0, green: 0, blue: 1, alpha: 1))

	texture.drawables[0] = .color(Color(red: 1, green: 1, blue: 0, alpha: 1))
	let item2 = Item(position: Point(x: 150, y: 40), texture: texture)
	item2.setPhysicsBody(relativePosition: Point(x: 0,y: 0),
	                     size: Size(100, 200),
	                     mass: 1,
	                     friction: 1)

	for i in 0...3 {
		var background = Texture()
		background.append(.color(Color(red: 1, green: Double(i) / 3, blue: 0, alpha: 1)))
		background.append(.rectangle(Rectangle(0, Double(i) * 100, 1000, 100)))

		world.backgrounds.append(background)
	}

	world.addItem(item)
	world.addItem(item2)
	world.addBlock(block)


	item.velocity.x = 100
	item.velocity.y = 100


*/

	var texture = Texture()

	var color = Color(red: 1, green: 0, blue: 0, alpha: 1)
	texture.append(.color(color))

	/*var rectangle = Rectangle(origin: Vector2D(40, 70),
							  size: Size(100, 200))*/
	var rectangle = Rectangle(0, 0, 100, 200)
	texture.append(.rectangle(rectangle))

	color = Color(red: 0, green: 1, blue: 0, alpha: 1)
	texture.append(.color(color))

	var polygon = Polygon()
	polygon.append(Vector2D(30, 40))
	polygon.append(Vector2D(50, 60))
	polygon.append(Vector2D(100, 40))
	polygon.append(Vector2D(30, 20))
	texture.append(.polygon(polygon))

	itemX.texture = texture

	itemX.setPhysicsBody(relativePosition: Point(x: 0, y: 0),
						 size: Size(100, 250),
					 	 mass: 1)

	itemX.velocity.x = 10
	world.addItem(itemX)

    var floor = Block(position: Point(x: -10000, y: -100),
				      size: Size(20000, 100 + 20),
			          color: Color(red: 1, green: 0, blue: 1, alpha: 1))
	world.addBlock(floor)
	
	let block1 = Block(position: Point(x: 400, y: 20),
	                   size: Size(50, 100),
	                   color: Color(red: 0, green: 1, blue: 1, alpha: 1))
	world.addBlock(block1)
	
	
	var itemY = Item(position: Point(x: 500, y: 100),
	                 size: Size(100, 200),
	                 color: Color(red: 1, green: 1, blue: 0, alpha: 1),
	                 friction: 1.0)
	world.addItem(itemY)
	
	var distance = 400.0
	var size = Size(50, 100)
	
	for x in 1...20 {
		var block = Block(position: Point(x: Double(x) * distance, y: 20 - 100),
		                  size: size,
		                  color: Color(red: 0, green: 1, blue: 1, alpha: 1))
		world.addBlock(block)
		
		var item = Item(position: Point(x: Double(x) * distance, y: 20),
		                size: size,
		                color: Color(red: 0, green: 1, blue: 1, alpha: 1),
		                friction: 20.0)
		world.addItem(item)
	}

}

var itemX = Item(position: Point(x: 100, y: 100))

func run() {
	world.position.x = 300 - itemX.position.x
}


func mouseMoved(position: Vector2D) {
	print(position)
	
	var x = 1280.0
	var y = 720.0
	
	var speed = 1000.0
	var jumpSpeed = 700.0
	
	itemX.velocity.x = position.x - x/2
	/*
	if position.x < x/2 {
		// mouse on left side
		itemX.velocity.x = -speed
	} else {
		// mouse on right side
		itemX.velocity.x = speed
	}*/
	
	if position.y < y/2 {
		itemX.velocity.y = jumpSpeed
		itemX.position.y += 1
	}
}

extension Item {
	
	convenience init(position: Point,
	     size: Size,
	     color: Color,
	     friction: Double = 0.0) {
		
		var texture = Texture()
		texture.append(.color(color))
		texture.append(.rectangle(Rectangle(
			origin: Vector2D(0, 0),
			size: size)))
		
		self.init(position: position,
		          texture: texture)
		
		self.physicsBody.size = size
		self.physicsBody.friction = friction
	}
}

