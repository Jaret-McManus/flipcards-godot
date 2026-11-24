class_name DeckPracticeController extends Node

const SubmissionType = DeckPracticeModel.SubmissionType

var _model: DeckPracticeModel


func on_practice_submission(type: SubmissionType) -> void:
	_model.next_card(type)


func bind_submission_buttons(
	easy_button: PaddedButton, 
	medium_button: PaddedButton, 
	hard_button: PaddedButton,
	dont_know_button: PaddedButton
) -> void:
	easy_button.pressed.connect(
		on_practice_submission.bind(SubmissionType.EASY)
	)
	medium_button.pressed.connect(
		on_practice_submission.bind(SubmissionType.MEDIUM)
	)
	hard_button.pressed.connect(
		on_practice_submission.bind(SubmissionType.HARD)
	)
	dont_know_button.pressed.connect(
		on_practice_submission.bind(SubmissionType.DONT_KNOW)
	)
