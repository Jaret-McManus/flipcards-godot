class_name DeckPractiveView extends SubcontentView

const DECK_PRACTICE_SCENE = preload("uid://rx0823junyny")

@export_group("Internal Nodes")
@export_subgroup("MVC")
@export var model: DeckPracticeModel
@export var controller: DeckPracticeController

@export_subgroup("Header")
@export var timer_label: Label
@export var progress_label: Label

@export_subgroup("In Progress Section")
@export var in_progress_section: VBoxContainer
@export var card_view: CardView

@export var easy_button: PaddedButton
@export var medium_button: PaddedButton
@export var hard_button: PaddedButton
@export var dont_know_button: PaddedButton

@export_subgroup("Finished Section")
@export var finished_section: VBoxContainer

@export_subgroup("Footer")
@export var back_to_deck_home: PaddedButton


static func create(deck: Deck) -> DeckPractiveView:
	var view: DeckPractiveView = DECK_PRACTICE_SCENE.instantiate()
	
	view.model.setup(deck)
	view._setup_controller(view.model)
	
	return view


func _ready() -> void: Assert.exports_nonnull(self)


func bind_signals_to_root(root_model: RootModel) -> void: 
	back_to_deck_home.pressed.connect(
		_transition_to_deck_home.bind(root_model)
	)


func _populate_finished_section(
	time_elapsed: String, cards_practiced: int, score: Score
) -> void:
	timer_label.text = "Finished in %s" % time_elapsed
	progress_label.text = "Studied %s cards" % cards_practiced
	print(score)


#region Signal Handlers
func _on_time_updated(time_string: String) -> void:
	timer_label.text = time_string


func _on_card_updated(card: Card, index: int, total_cards: int) -> void:
	card_view.card = card
	card_view.update_from_card()
	progress_label.text = "%s / %s" % [index + 1, total_cards]


func _on_practice_finished(
	time_elapsed: String, cards_practiced: int, score: Score
) -> void: 
	# switch to finished ui
	in_progress_section.visible = false
	
	_populate_finished_section(time_elapsed, cards_practiced, score)
	finished_section.visible = true
#endregion


func _setup_controller(p_model: DeckPracticeModel) -> void:
	controller._model = p_model
	controller.bind_submission_buttons(
		easy_button, medium_button, hard_button, dont_know_button
	)


func _transition_to_deck_home(root_model: RootModel) -> void:
	var deck_home_view := DeckHomeView.create(model.deck)
	root_model.set_subview(deck_home_view)
