extends Spatial

var arrRand := []
var arrGuess := []
var i := 0

onready var label = $"UI/Label"
onready var animator = $"UI/AnimationPlayer"

var CALL_NOW_TEXT = "CALL NOW: "


func _ready():
	arrRand.resize(6)
	randomize()
	for n in 6:
		arrRand[n] = randi()%9+1
		print(arrRand[n])
	label.set_bbcode("[center]" + CALL_NOW_TEXT + PoolStringArray(arrRand).join("") + "[/center]")

func _on_Phone_button_pressed(button):
	print(button)
	if button == 10 || button == 11:
		return
		
	arrGuess.append(button)
	if arrRand[i] != arrGuess[i]:
		print("false, try again")
		arrGuess = []
		i = 0
		label.set_bbcode("[center]" + CALL_NOW_TEXT + PoolStringArray(arrRand).join("") + "[/center]")
		animator.play("Wrong")
		return
	
	i += 1
	
	label.set_bbcode("[center]" + CALL_NOW_TEXT)
	
	label.push_color(Color(0, 1, 0))
	for n in i:
		label.append_bbcode(String(arrRand[n]))
	label.pop()

	label.push_color(Color(1, 1, 1))
	for n in range(i, 6):
		label.append_bbcode(String(arrRand[n]))
	label.pop()

	if i == 6:
		i = 0
		arrGuess.clear()
		label.set_bbcode("[center]" + CALL_NOW_TEXT + PoolStringArray(arrRand).join("") + "[/center]")
		animator.play("Correct")
		print("you won!")
