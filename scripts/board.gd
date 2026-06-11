extends Node2D

@export var tile_scene: PackedScene
@export var tile_count: int = 7

@onready var player = $"../Player"

var player_index := 0
var tiles := []
var connections := {}

var tile_positions = {
	0: Vector2(0, 0),

	1: Vector2(200, -100),
	2: Vector2(200, 100),

	3: Vector2(400, -150),
	4: Vector2(400, 150),

	5: Vector2(600, 0),

	6: Vector2(800, 0)
}

func _ready():
	generate_board()
	setup_connections()
	queue_redraw()
	move_to_tile(0)
	print(connections)

func setup_connections():
	connections[0] = [1, 2]
	connections[1] = [3]
	connections[2] = [4]
	connections[3] = [5]
	connections[4] = [5]
	connections[5] = [6]

func generate_board():
	for i in range(tile_count):
		var tile = tile_scene.instantiate()

		tile.index = i
		tile.position = tile_positions[i]
		tile.tile_clicked.connect(_on_tile_clicked)

		add_child(tile)
		tiles.append(tile)

func _on_tile_clicked(index):
	print("Estoy en:", player_index)
	print("Intento moverme a:", index)

	if can_move_to(index):
		print("Movimiento válido")
		move_to_tile(index)
	else:
		print("Movimiento inválido")

func can_move_to(target_index):
	if !connections.has(player_index):
		return false

	return target_index in connections[player_index]

func move_to_tile(index):
	player_index = index

	var target_tile = tiles[index]
	player.position = target_tile.position

func _draw():
	for from_index in connections:
		for to_index in connections[from_index]:
			draw_line(
				tile_positions[from_index],
				tile_positions[to_index],
				Color.WHITE,
				4.0
			)