extends Node

class_name MapGenerator

static func generate() -> MapData:
	var data = MapData.new()

	var layer_sizes = [1, 2, 3, 2, 1]

	var current_index = 0
	var layers = []

	# Crear nodos y posiciones
	for layer in range(layer_sizes.size()):
		var node_count = layer_sizes[layer]

		var layer_nodes = []

		for node in range(node_count):
			var x = layer * 250
			var y = (node - (node_count - 1) / 2.0) * 150

			data.tile_positions[current_index] = Vector2(x, y)

			layer_nodes.append(current_index)

			current_index += 1

		layers.append(layer_nodes)

	# Crear conexiones entre capas
	for layer in range(layers.size() - 1):
		var current_layer = layers[layer]
		var next_layer = layers[layer + 1]

		for node_index in range(current_layer.size()):
			var from_node = current_layer[node_index]

			var target_index = mini(node_index, next_layer.size() - 1)
			var to_node = next_layer[target_index]

			data.connections[from_node] = [to_node]

	# Garantizar que todos los nodos de la siguiente capa tengan entrada
	for layer in range(layers.size() - 1):
		var current_layer = layers[layer]
		var next_layer = layers[layer + 1]

		for next_node_index in range(next_layer.size()):
			var target_node = next_layer[next_node_index]

			var has_connection = false

			for from_node in current_layer:
				if data.connections.has(from_node):
					if target_node in data.connections[from_node]:
						has_connection = true
						break

			if !has_connection:
				var source_index = mini(next_node_index, current_layer.size() - 1)
				var source_node = current_layer[source_index]

				if !data.connections.has(source_node):
					data.connections[source_node] = []

				data.connections[source_node].append(target_node)

	return data