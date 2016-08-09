//
//  Item.swift
//  Swift 3 TestProject
//
//  Created by Maximilian Hünenberger on 27.7.16.
//
//

import Foundation

final class Item {

	var position: Point {
		get {
			return Point(x: physics.body.position.x - physics.relativePosition.x,
			             y: physics.body.position.y - physics.relativePosition.y)
		}
		set {
			physics.body.position = Point(x: newValue.x + physics.relativePosition.x,
			                              y: newValue.y + physics.relativePosition.y)
		}
	}
	var velocity: Vector2D {
		get { return physics.body.velocity }
		set { physics.body.velocity = newValue }
	}

	var texture: Texture

	var interacts: Bool
	var physics: (body: PhysicsBody, relativePosition: Point)

	var physicsBody: PhysicsBody {
		get { return physics.body }
		set { physics.body = newValue }
	}
	
	var itemCollisionHandler: (Item) -> ()
	var blockCollisionHandler: (Block) -> ()

	// MARK: - init
	init(position: Point,
	     interacts: Bool = true,
	     texture: Texture = Texture(),
	     itemCollisionHandler: (Item) -> () = { _ in },
		 blockCollisionHandler: (Block) -> () = { _ in }) {

		self.texture = texture
		self.interacts = interacts
		
		self.itemCollisionHandler = itemCollisionHandler
		self.blockCollisionHandler = blockCollisionHandler

		physics = (PhysicsBody(position: position, size: Size(0, 0), mass: 1),
		               Point(x: 0, y: 0))
	}

	func draw(offset: Vector2D) {
		texture.moved(Vector2D(position.x, position.y)).draw(offset: offset)
		//physicsBody.body.draw()
	}

	func setPhysicsBody(relativePosition: Point,
						size: Size,
	                    velocity: Vector2D = Vector2D(0,0),
	                    mass: Double,
	                    friction: Double = 0.0) {
		physics = (PhysicsBody(position: Point(x: self.position.x + relativePosition.x,
		                                           y: self.position.y + relativePosition.y),
		                           size: size,
		                           mass: mass,
		                           friction: friction),
		               relativePosition
		)
	}

	func interact(_ item: Item) {
		if interacts {
			if self.physics.body.interact(item.physics.body) {
				itemCollisionHandler(item)
			}
		}
	}
	func interact(_ block: Block) {
		if interacts {
			if self.physics.body.interact(block.physicsBody) {
				blockCollisionHandler(block)
			}
		}
	}

	func update(time: Double, forceField: (Point) -> Vector2D) {
		physics.body.update(time: time, forceField: forceField)
	}


}
