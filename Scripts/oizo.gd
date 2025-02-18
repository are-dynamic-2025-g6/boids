extends CharacterBody2D 
#Constantes experimentales

const VISION_SEPARATION = 20
const VISION_ALIGNEMENT = 40
const VISION_COHESION = 100
const AVOID_FACTOR = 0.05
var launched = false

@onready var refresh_rate : Timer = get_parent().get_node("refresh_rate")
@onready var main : Node2D = get_parent()
@onready var cage : Array #Contient les listes des oiseaux,c'est par cette liste qu'on peut les manipuler
var self_index : int  #index personnel dans la liste "cage" et dans le dictionnaire des distances
var dico_distances : Array

func _ready() -> void:
	refresh_rate.connect("timeout",boids.bind(get_physics_process_delta_time()))
	velocity = Vector2.ZERO #met a zero tout les deplacements

func _physics_process(delta: float):

	if Input.is_action_just_pressed("ui_accept"):
		cage = main.cage
		launched = true
	

	move_and_slide()


#Fonctions a coder de Boids :

func boids(delta): #Fonction appelée toutes les 0.3 secondes (temps modulable)
	print(delta)
	velocity.x = 200 * delta
	dico_distances = main.dico_distances
	#3 Listes
	if launched :
		coherence()
		alignement()
		separation()
		
	pass


func coherence():
	var proch_oizo = boids_in_range(VISION_COHESION)
	

func alignement():
	pass

func separation():
	var proche_x = 0
	var proche_y = 0
	var oiz = boids_in_range(VISION_SEPARATION)
	#CHANGEMENT
	if oiz:
		for i in oiz:
			proche_x += (position.x - cage[i].position.x)
			proche_y += (position.y - cage[i].position.y)
		curr_velo += Vector2(curr_velo.x + proche_x*AVOID_FACTOR ,curr_velo.y + proche_y*AVOID_FACTOR)
		return True
	else:
		return False
		
	

func boids_in_range(range : int):
	var res : Array = []
	for i in dico_distances[self_index]:
		if dico_distances[self_index][i] <= range :
			res.append(i.y)
	return res
