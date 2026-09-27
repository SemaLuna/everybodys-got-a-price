extends AudioStreamPlayer

func to_title():
	var playback = get_stream_playback() as AudioStreamPlaybackInteractive
	playback.switch_to_clip_by_name("Title")
	
func to_intro():
	var playback = get_stream_playback() as AudioStreamPlaybackInteractive
	playback.switch_to_clip_by_name("Intro")

func to_planning():
	var playback = get_stream_playback() as AudioStreamPlaybackInteractive
	playback.switch_to_clip_by_name("Planning")

func to_action():
	var playback = get_stream_playback() as AudioStreamPlaybackInteractive
	playback.switch_to_clip_by_name("Action")
	
func to_win():
	var playback = get_stream_playback() as AudioStreamPlaybackInteractive
	playback.switch_to_clip_by_name("Win")

func to_lose():
	var playback = get_stream_playback() as AudioStreamPlaybackInteractive
	playback.switch_to_clip_by_name("Lose")
