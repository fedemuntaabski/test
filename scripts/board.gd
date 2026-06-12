extends Node2D

@export var tile_scene: PackedScene
@export var tile_count := 7

@onready var player = $"../Player"

var player_index := 0
var tiles := []

var map_data : MapData

func _ready():
	map_data = MapGenerator.generate()

	generate_board()
	queue_redraw()
	move_to_tile(0)

func generate_board():
	for i in range(tile_count):
		var tile = tile_scene.instantiate()

		tile.index = i
		tile.position = map_data.tile_positions[i]

		tile.tile_clicked.connect(_on_tile_clicked)

		add_child(tile)
		tiles.append(tile)

func _on_tile_clicked(index):
	if can_move_to(index):
		move_to_tile(index)

func can_move_to(target_index):
	if !map_data.connections.has(player_index):
		return false

	return target_index in map_data.connections[player_index]

func move_to_tile(index):
	player_index = index

	var target_tile = tiles[index]
	player.position = target_tile.position

func _draw():
	for from_index in map_data.connections:
		for to_index in map_data.connections[from_index]:
			draw_line(
				map_data.tile_positions[from_index],
				map_data.tile_positions[to_index],
				Color.WHITE,
				4.0
			)