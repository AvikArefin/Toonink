extends Control

var effect# : AudioEffectRecord
var recording


func _ready() -> void:
	# We get the index of the "Record" bus.
	var idx = AudioServer.get_bus_index("Record")
	# And use it to retrieve its first effect, which has been defined
	# as an "AudioEffectRecord" resource.
	effect = AudioServer.get_bus_effect(idx, 0)

func _on_Record_pressed() -> void:
	print_debug("record pressed")
	if effect.is_recording_active():
		print_debug("stoping the recording")
		recording = effect.get_recording()
#		$Play.disabled = false
		$Save.disabled = false
		effect.set_recording_active(false)
		$Record.text = "Record"
		$Status.text = ""
	else:
#		$Play.disabled = true
		$Save.disabled = true
		effect.set_recording_active(true)
		$Record.text = "Stop"
		$Status.text = "Recording..."

func _on_Save_pressed() -> void:
	var file_name = "user://tunes_test.wav"
	recording.save_to_wav(file_name)
	$Status.text = "Saved WAV file to: %s\n(%s)" % [file_name, ProjectSettings.globalize_path(file_name)]




