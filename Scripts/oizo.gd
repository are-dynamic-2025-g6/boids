extends CharacterBody2D 
#Constantes experimentales

const VISION_SEPARATION = 20
const VISION_ALIGNEMENT = 40
const VISION_COHESION = 100
var launched = false

@onready var refresh_rate : Timer = get_parent().get_node("refresh_rate")
@onready var main : Node2D = get_parent()
@onready var cage : Array #Contient les listes des oiseaux,c'est par cette liste qu'on peut les manipuler
var self_index : int  #index personnel dans la liste "cage" et dans le dictionnaire des distances
var dico_distances : Array

func _ready() -> void:
	refresh_rate.connect("timeout",boids)
	velocity = Vector2.ZERO #met a zero tout les deplacements

func _physics_process(delta: float):

	if Input.is_action_just_pressed("ui_accept"):
		cage = main.cage
		launched = true
	

	move_and_slide()


#Fonctions a coder de Boids :

func boids(): #Fonction appelée toutes les 0.3 secondes (temps modulable)
	dico_distances = main.dico_distances
	#3 Listes
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
	var proche_x = 0
	var proche_y = 0
	for i in boids_in_range(VISION_SEPARATION):
		proche_x = proche_x + 
	
	

func boids_in_range(distance : int):
	pass
