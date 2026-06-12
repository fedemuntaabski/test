extends Node

class_name MapGenerator

static func generate() -> MapData:
	var data = MapData.new()

	data.tile_positions = {
		0: Vector2(0, 0),

		1: Vector2(200, -100),
		2: Vector2(200, 100),

		3: Vector2(400, -150),
		4: Vector2(400, 150),

		5: Vector2(600, 0),

		6: Vector2(800, 0)
	}

	data.connections = {
		0: [1, 2],
		1: [3],
		2: [4],
		3: [5],
		4: [5],
		5: [6]
	}

	return data