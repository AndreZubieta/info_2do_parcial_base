extends TextureRect

@onready var score_label = $MarginContainer/HBoxContainer/score_label
@onready var counter_label = $MarginContainer/HBoxContainer/counter_label
@onready var goal_label = $MarginContainer/HBoxContainer/goal_label
@onready var game_over_panel = get_parent().get_node("GameOverPanel")
@onready var result_label = get_parent().get_node("GameOverPanel/ResultLabel")
@onready var restart_button = get_parent().get_node("GameOverPanel/RestartButton")


var current_score = 0
var current_count = 0

# Conecta estos métodos a las señales del tablero (grid.gd), por ejemplo en _ready:
#   var grid = get_parent().get_node("grid")
#   grid.score_changed.connect(update_score)
#   grid.counter_changed.connect(update_counter)

func _ready():
	var grid = get_parent().get_node("grid")

	grid.score_changed.connect(update_score)
	grid.counter_changed.connect(update_counter)
	grid.game_finished.connect(show_game_over)
	restart_button.pressed.connect(restart_game)

	goal_label.text = " Goal\n %d" % grid.target_score

func update_score(nuevo_puntaje: int) -> void:
	current_score = nuevo_puntaje
	# TODO (PARCIAL · B1): refleja current_score en score_label.text con el formato que prefieras.
	score_label.text = "Score\n%d" % current_score

func update_counter(restantes: int) -> void:
	current_count = restantes
	# TODO (PARCIAL · B2): refleja current_count en counter_label.text.
	counter_label.text = "%d" % current_count

func show_game_over(gano: bool):
	game_over_panel.visible = true

	if gano:
		result_label.text = "¡GANASTE!"
	else:
		result_label.text = "PERDISTE"

func restart_game():
	get_tree().reload_current_scene()
