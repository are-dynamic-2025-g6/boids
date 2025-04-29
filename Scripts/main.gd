extends Node2D

@onready var refresh_rate: Timer = $refresh_rate
@onready var Analyse: Timer = $Analyse
var oizo : PackedScene = preload("res://Scenes/oizo.tscn")
var cage : Array[Node]
var dico_distances : Array
var curr_dist : float
var l=[]
var L=[]
var k=true
var made : bool = true
var compte_analyse : int = 0
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
	Analyse.start()


func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("print"):
	#	print(dico_distances)
	pass



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

func array_coord():
	return
	compte_analyse += 1
	var path = OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP) + "/Sc-Fo/Boids/boids/Analyse/"
	var dir = DirAccess.open(OS.get_system_dir(OS.SYSTEM_DIR_DESKTOP))
	var file : FileAccess
	if compte_analyse < 20 :
		if made :
			file = FileAccess.open(path + "data_sim_coords.csv", FileAccess.WRITE)
			#file.store_csv_line(["x", "y"])
			made = false
			print("premiere fois")
		else :
			file = FileAccess.open(path + "data_sim_coords.csv", FileAccess.READ_WRITE)
			file.seek_end() 
			file.store_csv_line(["#Simulation suivante"])
			print("deuxieme fois")
		#var coords : Array = []
		for i in cage :
			file.store_csv_line([i.global_position.x, i.global_position.y])
			#coords.append(i.global_position)
		#print(coords)

func proche(): #a connecter au timer analyse pour analyse,sans oublier le print en bas
	l=[]
	for i in dico_distances:
		k=true
		for j in i:
			if i[j]<p and k==true:
				l.append(1)
				k=false
	L.append(len(l))

func _on_analyse_timeout() -> void:
	pass
	#proche()
	#print(len(l),L)
