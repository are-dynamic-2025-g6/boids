extends Node2D
var oizo : PackedScene = preload("res://Scenes/oizo.tscn")


func _ready() -> void:
	for i in range(50):
		var oizoo : CharacterBody2D = oizo.instantiate()
		oizoo.position = Vector2(300,200) #coordonnées aleatoires
		print(oizoo.position)
		add_child(oizoo)
