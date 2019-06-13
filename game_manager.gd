extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#var dave_pic = preload("res://art/characters/dave.jpg")
#var miah_pic = preload("res://art/characters/Jeremiah.jpg")
#var john_pic = preload("res://art/characters/JOhn_P.jpg")
#ar merlin_pic = preload("res://art/characters/Merlin.jpg")
#var mr_t_pic = preload("res://art/characters/mr_T.jpg")
#var rodney_pic = preload("res://art/characters/RodneyD.jpg")
#var burns_pic = preload("res://art/characters/George_Burns.png")
#var ben_pic = preload("res://art/characters/Ben.jpg")
var human_player
var cpu_player


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var dave_pic = preload("res://art/characters/dave.jpg")
enum dave_move_list {}
var dave = {"picture": dave_pic, "speed": 20, "stamina": 100,
			"power": 12, "toughness": 16, "charisma": 8, 
			"size": 9, "move_list": dave_move_list}

var miah_pic = preload("res://art/characters/Jeremiah.jpg")
enum miah_move_list {}
var miah = {
			"picture": miah_pic, "speed": 16, "stamina": 100, 
			"power": 17, "toughness": 15, "charisma": 13,
			"size": 15 , "move_list": miah_move_list 
			}

var john_pic = preload("res://art/characters/JOhn_P.jpg")
enum john_move_list {}
var john = {
			"picture": john_pic, "speed": 19, "stamina": 100, 
			"power": 11, "toughness": 14, "charisma": 16,
			"size": 10 , "move_list": john_move_list 
			}

var ben_pic = preload("res://art/characters/Ben.jpg")
enum ben_move_list {}
var ben = {
			"picture": ben_pic, "speed": 18, "stamina": 100, 
			"power": 15, "toughness": 15, "charisma": 16,
			"size": 14 , "move_list": ben_move_list 
			}
			
var merlin_pic = preload("res://art/characters/Merlin.jpg")
enum merlin_move_list {}
var merlin = {
			"picture": merlin_pic, "speed": 13, "stamina": 100, 
			"power": 13, "toughness": 10, "charisma": 14,
			"size": 15 , "move_list": merlin_move_list 
			}

var mr_t_pic = preload("res://art/characters/mr_T.jpg")
enum mr_t_move_list {}
var mr_t = {
			"picture": mr_t_pic, "speed": 12, "stamina": 100, 
			"power": 19, "toughness": 18, "charisma": 14,
			"size": 16 , "move_list": mr_t_move_list 
			}

var rodney_pic = preload("res://art/characters/RodneyD.jpg")			
enum rodney_move_list {}			
var rodney = {
			"picture": merlin_pic, "speed": 10, "stamina": 100, 
			"power": 11, "toughness": 9, "charisma": 19,
			"size": 15 , "move_list": rodney_move_list 
			}

var george_pic = preload("res://art/characters/George_Burns.png")			
enum george_move_list {}			
var george = {
			"picture": george_pic, "speed": 10, "stamina": 100, 
			"power": 9, "toughness": 9, "charisma": 19,
			"size": 9 , "move_list": george_move_list 
			}
func get_player(player_name):
	match player_name:
		"Dave":
			return dave
		"John":
			return john
		"Miah":
			return miah
		"Merlin":
			return merlin
		"Ben":
			return ben
		"Rodney":
			return rodney
		"George":
			return george