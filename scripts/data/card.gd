class_name Card extends Resource

enum SubmissionType { EASY, MEDIUM, HARD, DONT_KNOW }

@export var side_a_text: String
@export var side_b_text: String

# scores
@export var score: Score


static func new_card(p_side_a_text: String, p_side_b_text: String) -> Card:
	var card: Card = Card.new()
	card.side_a_text = p_side_a_text
	card.side_b_text = p_side_b_text
	card.score = Score.new_score()
	return card


func update_score(type: SubmissionType) -> void:
	score.add_submission(type)

func _to_string() -> String:
	return "Card:<%s|%s>" % [side_a_text, side_b_text]
