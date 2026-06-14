extends TextureRect

@onready var score_label = $score_label
@onready var counter_label = $counter_label
@onready var goal_label = $goal_label
@onready var game_over_panel = get_parent().get_node("GameOverPanel")
@onready var result_label = get_parent().get_node("GameOverPanel/ResultLabel")
@onready var restart_button = get_parent().get_node("GameOverPanel/RestartButton")
@onready var next_level_button = get_parent().get_node("GameOverPanel/NextLevelButton")
@onready var level_label = get_parent().get_parent().get_node("Game/bottom_ui/LevelLabel")

var current_score = 0
var current_count = 0

# Conecta estos métodos a las señales del tablero (grid.gd), por ejemplo en _ready:
#   var grid = get_parent().get_node("grid")
#   grid.score_changed.connect(update_score)
#   grid.counter_changed.connect(update_counter)
var grid

func _ready():
	grid = get_parent().get_node("grid")

	grid.score_changed.connect(update_score)
	grid.counter_changed.connect(update_counter)
	grid.game_finished.connect(show_game_over)
	restart_button.pressed.connect(restart_game)
	next_level_button.pressed.connect(next_level)
	await get_tree().process_frame
	refresh_ui()
	
func show_game_over(gano: bool):
	game_over_panel.visible = true

	if gano:
		result_label.text = "¡GANASTE!"
		next_level_button.visible = true
		restart_button.visible = true
	else:
		result_label.text = "PERDISTE"
		next_level_button.visible = false
		restart_button.visible = true

func refresh_ui():
	update_level()
	update_goal()
	update_score(current_score)
	update_counter(current_count)

func restart_game():
	get_tree().reload_current_scene()

func next_level():
	grid.load_next_level()
	get_tree().reload_current_scene()

func update_level():
	var level = grid.get_current_level()
	print("LEVEL RAW:", level)
	level_label.text = level["name"]

func update_goal():
	var level = grid.get_current_level()

	if level["goal_type"] == "score":
		goal_label.text = "Goal\n%d" % level["goal_value"]

	elif level["goal_type"] == "collect_color":
		goal_label.text = "Goal\n%d %s" % [
			level["goal_value"],
			level["goal_color"]
		]

func update_score(nuevo_puntaje: int) -> void:
	current_score = nuevo_puntaje
	# TODO (PARCIAL · B1): refleja current_score en score_label.text con el formato que prefieras.
	score_label.text = "Score\n%d" % current_score

func update_counter(restantes: int) -> void:
	current_count = restantes
	# TODO (PARCIAL · B2): refleja current_count en counter_label.text.
	counter_label.text = "%d" % current_count
