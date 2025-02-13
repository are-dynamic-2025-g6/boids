extends CharacterBody2D 
var launched = false

func _physics_process(delta: float):
	if Input.is_action_just_pressed("ui_accept"):
		launched = true
	velocity = Vector2.ZERO
	if launched :
		print("chef")
		coherence()
		alignement()
		separation()
		
	#move_and_slide() #Je le mettrai quand j'aurais fait apparaitre les oiseaux en aleatoire

#Fonctions a coder de Boids :

func coherence():
	pass

func alignement():
	pass

func separation():
	pass
