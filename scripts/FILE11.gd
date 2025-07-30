extends AudioStreamPlayer

var volume_level = 0.5
var pitch_scale_value = 1.0
var audio_files = []

func _ready():
	volume_db = linear_to_db(volume_level)
	pitch_scale = pitch_scale_value

func play_sound(sound_path: String):
	if ResourceLoader.exists(sound_path):
		stream = load(sound_path)
		play()

func set_volume_level(level: float):
	volume_level = clamp(level, 0.0, 1.0)
	volume_db = linear_to_db(volume_level)

func set_pitch(pitch: float):
	pitch_scale_value = clamp(pitch, 0.1, 3.0)
	pitch_scale = pitch_scale_value

func fade_in(duration: float):
	var tween = create_tween()
	tween.tween_method(set_volume_level, 0.0, volume_level, duration)

func fade_out(duration: float):
	var tween = create_tween()
	tween.tween_method(set_volume_level, volume_level, 0.0, duration)

func get_audio_info():
	return {
		"volume": volume_level,
		"pitch": pitch_scale_value,
		"playing": playing,
		"stream_position": get_playback_position()
	}

func add_audio_file(file_path: String):
	if not file_path in audio_files:
		audio_files.append(file_path)

func play_random_audio():
	if audio_files.size() > 0:
		var random_index = randi() % audio_files.size()
		play_sound(audio_files[random_index])
