extends Node2D

@export var tile_scene: PackedScene
@export var tile_count: int = 12
@onready var player = $"../Player"


var player_index = 0
var tiles = []

func _ready():
	generate_board()
	move_player(0)

func generate_board():
	for i in range(tile_count):
		var tile = tile_scene.instantiate()

		tile.index = i
		tile.position = Vector2(i * 180, 0)

		tile.tile_clicked.connect(_on_tile_clicked)

		add_child(tile)
		tiles.append(tile)

func _on_tile_clicked(index):
	player_index = index
	var target_tile = tiles[index]
	player.position = target_tile.position

func move_player(steps):
	player_index = (player_index + steps) % tile_count
	var target_tile = tiles[player_index]
	player.position = target_tile.position

