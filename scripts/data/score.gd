class_name Score extends Resource

const SubmissionType = Card.SubmissionType

@export var easy_count: int = 0
@export var medium_count: int = 0
@export var hard_count: int = 0
@export var dont_know_count: int = 0
@export var practice_count: int = 0


static func new_score() -> Score:
	var score: Score = Score.new()
	return score


func add_submission(type: SubmissionType) -> void:
	match type:
		SubmissionType.EASY:
			easy_count += 1
		SubmissionType.MEDIUM:
			medium_count += 1
		SubmissionType.HARD:
			hard_count += 1
		SubmissionType.DONT_KNOW:
			dont_know_count += 1
		_: assert(false, "Unkown card submission type")
	
	# match statement may possibly fail
	# so update total count afterwards
	practice_count += 1
