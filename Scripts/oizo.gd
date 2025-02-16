extends CharacterBody2D 
var launched = false
@onready var refresh_rate : Timer = get_parent().get_node("refresh_rate")
@onready var main : Node2D = get_parent()
var self_index : int  #index personnel dans la liste "cage" et dans le dictionnaire des distances
var dico_distances : Array

func _ready() -> void:
	refresh_rate.connect("timeout",boids)
	velocity = Vector2.ZERO #met a zero tout les deplacements

func _physics_process(delta: float):
	if Input.is_action_just_pressed("ui_accept"):
		launched = true
	

	move_and_slide()


#Fonctions a coder de Boids :

func boids(): #Fonction appelée toutes les 0.3 secondes (temps modulable)
	dico_distances = main.dico_distances
	if launched :
		print(dico_distances[self_index])
		coherence()
		alignement()
		separation()
		
	pass


func coherence():
	pass

func alignement():
	pass

func separation():
	pass
