# Play/pause music like in smartphones
# Play when the headphone was plugged in, pause when the headphone was unplugged

# Based on https://askubuntu.com/a/879185/279745

# As there is no separate option in Audacious for playing even if it is already playing (or for pausing even if it is already paused), only toggles (e.g. play when paused, otherwise pause), I was forced to check the stateAud of playback from PulseAudio (using `pacmd`).

# Added control for vlc (src: https://stackoverflow.com/a/43156436/3408342)

#!/bin/bash
acpi_listen | while IFS= read -r line; do
	test=$(pacmd list-sink-inputs | grep "application.process.binary\|state" | \sed 's/[="]//g' - | awk '{print $2}')
	if [[ $test ]]; then
		stateAud=$(echo "$test" | grep audacious -B1 | head -1)
		stateVlc=$(echo "$test" | grep vlc -B1 | head -1)

		# Play music when headphone jack has been plugged in AND the stateAud is corked/paused
		if [[ "$line" = "jack/headphone HEADPHONE plug" && $stateAud = "CORKED" ]]; then
			audacious -t
		fi
		if [[ "$line" = "jack/headphone HEADPHONE plug" && $stateVlc = "CORKED" ]]; then
			dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Play
		fi
		if [[ "$line" = "jack/headphone HEADPHONE unplug" && $stateAud = "RUNNING" ]]; then
			audacious -t
		fi
		if [[ "$line" = "jack/headphone HEADPHONE unplug" && $stateVlc = "RUNNING" ]]; then
			dbus-send --type=method_call --dest=org.mpris.MediaPlayer2.vlc /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause
		fi
		echo
	fi
done