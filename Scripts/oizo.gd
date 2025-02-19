extends CharacterBody2D 
#Constantes experimentales

const VISION_SEPARATION = 50
const VISION_ALIGNEMENT = 150
const VISION_COHESION = 200
const AVOID_FACTOR = 0.5
const MATCHING_FACTOR = 0.5
const CENTERING_FACTOR = 0.5
const MAX_SPEED = 15000
const MIN_SPEED = 2000
var launched = false

@onready var refresh_rate : Timer = get_parent().get_node("refresh_rate")
@onready var main : Node2D = get_parent()
@onready var cage : Array #Contient les listes des oiseaux,c'est par cette liste qu'on peut les manipuler
var self_index : int  #index personnel dans la liste "cage" et dans le dictionnaire des distances
var dico_distances : Array
var curr_velo : Vector2
#var normaliseur : int

func _ready() -> void:
	refresh_rate.connect("timeout",boids)
	#Definir une velocité de depart aleatoire 
	curr_velo = Vector2(randi_range(-2000,2000),randi_range(-2000, 2000)) #ATTENTION pour visualiser le bug, mettre a (1, 1)

func _physics_process(delta: float):
	#velocity.x = 200 * delta #mouvement basique de gauche a droite,qui sera remplacé par la ligne d'en dessous
	velocity = curr_velo * delta   #Curr_velo sera notre vecteur direction a modifier
	print(velocity) #ATTENTION, je crois le probleme viens d'ici, on peut voir que la vélocité 
	#ne change pas avec ce print, meme avec l'influence des trois fonctions, je pense que la fonction boids()
	#n'est genre appeler que une fois, ou pas appeler asser vite, ENFT je sais pas pk la velocité ne change pas bref.
	if Input.is_action_just_pressed("ui_accept"):
		cage = main.cage
		launched = true

	move_and_slide()


#Fonctions a coder de Boids :

func boids():
	#normaliseur = 1 je crois pas besoin de normaliseur vu que vitesse min et max, a voir.
	dico_distances = main.dico_distances
	if launched :
		coherence()
		alignement()
		separation()
		#normaliseur = normaliseur + 1 if coherence() else normaliseur 
		#normaliseur = normaliseur + 1 if alignement() else normaliseur 
		#normaliseur = normaliseur + 1 if separation() else normaliseur 
		#Calcule de vitesse
		var speed = sqrt(velocity.x**2 + velocity.y**2)
		if speed > MAX_SPEED:
			curr_velo = Vector2((velocity.x/speed)*MAX_SPEED, (velocity.y/speed)*MAX_SPEED)
		if speed < MIN_SPEED:
			curr_velo = Vector2((velocity.x/speed)*MIN_SPEED, (velocity.y/speed)*MIN_SPEED)
		


func coherence():
	var moy_xpos = 0
	var moy_ypos = 0
	var oiz_coh = boids_in_range(VISION_COHESION)
	var oizo_vus = len(oiz_coh)
	if oizo_vus > 0:
		for i in oiz_coh:
			moy_xpos += cage[i].position.x
			moy_ypos += cage[i].position.y
		moy_xpos = moy_xpos/oizo_vus
		moy_ypos = moy_ypos/oizo_vus
		curr_velo += Vector2((moy_xpos-position.x)*CENTERING_FACTOR, (moy_ypos- position.y)*CENTERING_FACTOR)
		return true
	else:
		return false
	

func alignement():
	var moy_xvel = 0
	var moy_yvel = 0
	var oiz_al = boids_in_range(VISION_ALIGNEMENT)
	var oizo_vus = len(oiz_al)
	if oizo_vus > 0:
		for i in oiz_al:
			moy_xvel += cage[i].velocity.x
			moy_yvel += cage[i].velocity.y
		moy_xvel = moy_xvel/oizo_vus
		moy_yvel = moy_yvel/oizo_vus
		curr_velo += Vector2((moy_xvel-velocity.x)*MATCHING_FACTOR, (moy_yvel-velocity.y)*MATCHING_FACTOR)
		return true
	else:
		return false

func separation():
	var proche_x = 0
	var proche_y = 0
	var oiz_sep = boids_in_range(VISION_SEPARATION)
	if oiz_sep:
		for i in oiz_sep:
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
