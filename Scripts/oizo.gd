extends CharacterBody2D 
#Next session : Bordures
#Afficher les cercles de visions
#Constantes experimentales
#faire en sorte que le tout soit centrer quand ouvre grand fenetre

const VISION_SEPARATION = 30 #plus on augmente ca moins ils ce rentrent dedans
const VISION_ALIGNEMENT = 60
const VISION_COHESION = 150
const AVOID_FACTOR = 15
const MATCHING_FACTOR = 1
const CENTERING_FACTOR = 2
const MAX_SPEED = 14000
const MIN_SPEED = 13000
const TURN = 1000
var launched = false
var normaliseur : int 
@onready var refresh_rate : Timer = get_parent().get_node("refresh_rate")
@onready var main : Node2D = get_parent()
@onready var cage : Array #Contient les listes des oiseaux,c'est par cette liste qu'on peut les manipuler
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var self_index : int  #index personnel dans la liste "cage" et dans le dictionnaire des distances
var dico_distances : Array
var curr_velo : Vector2
#var normaliseur : int

func _ready() -> void:
	refresh_rate.connect("timeout",boids)
	#Definir une velocité de depart aleatoire 
	curr_velo = Vector2(randi_range(-2000,2000),randi_range(-2000, 2000)) #ATTENTION pour visualiser le bug, mettre a (1, 1)
	#animated_sprite_2d.play("blue1")

func _physics_process(delta: float):
	#velocity.x = 200 * delta #mouvement basique de gauche a droite,qui sera remplacé par la ligne d'en dessous
	velocity = curr_velo * delta   #Curr_velo sera notre vecteur direction a modifier
	rotation = velocity.angle() + PI/2
	
	#print(velocity) #ATTENTION, je crois le probleme viens d'ici, on peut voir que la vélocité 
	#ne change pas avec ce print, meme avec l'influence des trois fonctions, je pense que la fonction boids()
	#n'est genre appeler que une fois, ou pas appeler asser vite, ENFT je sais pas pk la velocité ne change pas bref.
	if Input.is_action_just_pressed("ui_accept"):
		cage = main.cage
		launched = true

	move_and_slide()


#Fonctions a coder de Boids :

func boids():
	normaliseur = 1 #je crois pas besoin de normaliseur vu que vitesse min et max, a voir.
	dico_distances = main.dico_distances
	if launched :
		#coherence()
		#alignement()
		#separation()
		normaliseur = normaliseur + 1 if coherence() else normaliseur 
		normaliseur = normaliseur + 1 if alignement() else normaliseur 
		normaliseur = normaliseur + 1 if separation() else normaliseur 
		#Calcule de vitesse
		var speed = sqrt(curr_velo.x**2 + curr_velo.y**2)
		if speed > MAX_SPEED:
			curr_velo = Vector2((curr_velo.x/speed)*MAX_SPEED, (curr_velo.y/speed)*MAX_SPEED)
		if speed < MIN_SPEED:
			curr_velo = Vector2((curr_velo.x/speed)*MIN_SPEED, (curr_velo.y/speed)*MIN_SPEED)
		curr_velo  = curr_velo / (normaliseur)
		
<<<<<<< HEAD
		#tentative reste dans écrans
		#les valeurs correspoindent a peux pres a la taille de l'écran, mais à adapter
		#petit probleme ils tournent tous dans le meme sens = relou
		stay_in_screen_turn()
		#stay_in_screen_inv()
=======
		#stay_in_screen_turn()
		stay_in_screen_inv()
>>>>>>> bfe269f9d767d33aaa15d793d2011cae1273fd57


func stay_in_screen_turn() :
	if position.x < 50:
		curr_velo.x += TURN
	if position.x > 1090:
		curr_velo.x -= TURN
	if position.y < 50:
		curr_velo.y += TURN
	if position.y > 550:
		curr_velo.y -= TURN
		
func stay_in_screen_inv():
	if position.x > 1140 or position.x < 10 :
		curr_velo.x = -curr_velo.x
	elif position.y > 630  or position.y < 10 :
		curr_velo.y = -curr_velo.y

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
			moy_xvel += cage[i].curr_velo.x
			moy_yvel += cage[i].curr_velo.y
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
