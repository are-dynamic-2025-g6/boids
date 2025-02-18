extends CharacterBody2D 
#Constantes experimentales

const VISION_SEPARATION = 50
const VISION_ALIGNEMENT = 100
const VISION_COHESION = 160
const AVOID_FACTOR = 0.4
var launched = false

@onready var refresh_rate : Timer = get_parent().get_node("refresh_rate")
@onready var main : Node2D = get_parent()
@onready var cage : Array #Contient les listes des oiseaux,c'est par cette liste qu'on peut les manipuler
var self_index : int  #index personnel dans la liste "cage" et dans le dictionnaire des distances
var dico_distances : Array
var curr_velo : Vector2
var normaliseur : int

func _ready() -> void:
	refresh_rate.connect("timeout",boids)
	#Definir une velocité de depart aleatoire :
	curr_velo = Vector2(1000,0)  

func _physics_process(delta: float):
	#velocity.x = 200 * delta #mouvement basique de gauche a droite,qui sera remplacé par la ligne d'en dessous
	velocity = curr_velo * delta   #Curr_velo sera notre vecteur direction a modifier
	
	if Input.is_action_just_pressed("ui_accept"):
		cage = main.cage
		launched = true
	

	move_and_slide()


#Fonctions a coder de Boids :

func boids():
	normaliseur = 1
	dico_distances = main.dico_distances
	if launched :
		coherence()
		alignement()
		normaliseur = normaliseur + 1 if separation() else normaliseur 
		curr_velo  = curr_velo / normaliseur
		


func coherence():
	var proch_oizo = boids_in_range(VISION_COHESION)
	

func alignement():
	pass

func separation():
	var proche_x = 0
	var proche_y = 0
	var oiz = boids_in_range(VISION_SEPARATION)
	if oiz:
		print(oiz)
		for i in oiz:
			proche_x += (position.x - cage[i].position.x)
			proche_y += (position.y - cage[i].position.y)
		curr_velo += Vector2(curr_velo.x + proche_x*AVOID_FACTOR ,curr_velo.y + proche_y*AVOID_FACTOR)
		return true
	else:
		return false


func boids_in_range(range : int):
	var res : Array = []
	for i in dico_distances[self_index]:
		if dico_distances[self_index][i] <= range :
			res.append(i.y)
	return res
