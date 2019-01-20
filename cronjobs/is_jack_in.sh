# Play/pause music like in smartphones
# Play when the headphone was plugged in, pause when the headphone was unplugged

# Based on https://askubuntu.com/a/879185/279745

# As there is no separate option in Audacious for playing even if it is already playing (or for pausing even if it is already paused), only toggles (e.g. play when paused, otherwise pause), I was forced to check the state of playback from PulseAudio (using `pacmd`).

#!/bin/bash
acpi_listen | while IFS= read -r line; do
	test=$(pacmd list-sink-inputs | grep "application.process.binary\|state" | \sed 's/[="]//g' - | awk '{print $2}')
	if [[ $test ]]; then
		state=$(echo "$test" | grep audacious -B1 | head -1)

		# Play music when headphone jack has been plugged in AND the state is corked/paused
		if [[ "$line" = "jack/headphone HEADPHONE plug" && $state = "CORKED" ]]; then
			audacious -t
		fi
		if [[ "$line" = "jack/headphone HEADPHONE unplug" && $state = "RUNNING" ]]; then
			audacious -t
		fi
		echo
	fi
done