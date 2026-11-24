class_name DeckPractiveView extends SubcontentView

const DECK_PRACTICE_SCENE = preload("uid://rx0823junyny")

@export_group("Internal Nodes")
@export var model: DeckPracticeModel
@export var timer_label: Label
@export var back_to_deck_home: PaddedButton


static func create(deck: Deck) -> DeckPractiveView:
	var view: DeckPractiveView = DECK_PRACTICE_SCENE.instantiate()
	view.model.setup(deck)
	return view


func bind_signals_to_root(root: RootView) -> void: 
	back_to_deck_home.pressed.connect(
		_transition_to_deck_home.bind(root)
	)


func _on_time_updated(time_string: String) -> void:
	timer_label.text = time_string


func _transition_to_deck_home(root: RootView) -> void:
	root.set_subview(
		DeckHomeView.create(model.deck)
	)
