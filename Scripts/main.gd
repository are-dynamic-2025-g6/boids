extends Node2D

@onready var refresh_rate: Timer = $refresh_rate
@onready var Annalyse: Timer = $Annalyse
var oizo : PackedScene = preload("res://Scenes/oizo.tscn")
var cage : Array[Node]
var dico_distances : Array
var curr_dist : float
var l=[]
var L=[]
var k=true
const p=10
const NB_OIZO = 125

func _ready() -> void:
	#gere les doublons au spawn
	for i in range(NB_OIZO):
		var oizoo : CharacterBody2D = oizo.instantiate()
		oizoo.position = Vector2(randi_range(0,1140),randi_range(0,620)) #coordonnées aleatoires
		oizoo.self_index = i
		oizoo.z_index = 1
		print(oizoo.position)
		add_child(oizoo)
		dico_distances.append({})
		
	cage = get_tree().get_nodes_in_group("Zoizos")
	refresh_rate.start()
	Annalyse.start()


func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("print"):
	#	print(dico_distances)
	pass


func _on_timer_timeout() -> void:
	get_dico_distances()


func get_dico_distances():
	"""
	Met a jour la liste de dictionnaires,de la forme :
	dico_distances = List[dict[(i,k):distance] -> c'est a dire que chaque oiseau,de par son indice,possede un
	dictionnaire entier de ses distances avec les autres.Pour avoir ce dictionnaire : dico_distance[i] avec i
	l'indice de l'oiseau dans la liste cage.
	"""
	
	for i in range(len(cage)):
		for k in range(i+1,len(cage)):
			curr_dist = distance(cage[i],cage[k])
			dico_distances[i][Vector2(i,k)] = curr_dist
			dico_distances[k][Vector2(k,i)] = curr_dist
			#dico_distances[Vector2(i,k)] = distance(cage[i],cage[k])



func distance(obj1 : CharacterBody2D,obj2 : CharacterBody2D) -> float :
	return ((obj1.global_position.x-obj2.global_position.x)**2 + (obj1.global_position.y - obj2.global_position.y)**2)**0.5

func val_change(value : int,param : String) :
	for i in cage :
		match param :
			"coherence" :
				i.VISION_COHESION = value
			"alignment" :
				i.VISION_ALIGNEMENT = value
			"avoid" :
				i.VISION_SEPARATION = value
			"speed":
				Engine.time_scale = float(value) / 100

func proche():
	l=[]
	for i in dico_distances:
		k=true
		for j in i:
			if i[j]<p and k==true:
				l.append(1)
				k=false
	L.append(len(l))

func _on_annalyse_timeout() -> void:
	proche()
	print(len(l),L)
