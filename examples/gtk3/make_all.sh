#!/usr/bin/env bash
#
# Make all .nim files in current directory
# Progress bar from https://github.com/bahamas10/ysap
#

BATCHSIZE=1
BAR_CHAR='#'
EMPTY_CHAR='.'

fatal() {
	echo '[FATAL]' "$@" >&2
	exit 1
}

progress-bar() {
	local current=$1
	local len=$2

	local perc_done=$((current * 100 / len))

	local suffix=" $current/$len ($perc_done%)"

	local length=$((COLUMNS - ${#suffix} - 2))
	local num_bars=$((perc_done * length / 100))

	local i
	local s='['
	for ((i = 0; i < num_bars; i++)); do
		s+=$BAR_CHAR
	done
	for ((i = num_bars; i < length; i++)); do
		s+=$EMPTY_CHAR
	done
	s+=']'
	s+=$suffix

	printf '\e7' # save the cursor location
	  printf '\e[%d;%dH' "$LINES" 0 # move cursor to the bottom line
	  printf '\e[0K' # clear the line
	  printf '%s' "$s" # print the progress bar
	printf '\e8' # restore the cursor location
}

process-files() {
	local files=("$@")
	local file
	for file in "${files[@]}"; do
		nim c $file
	done
}

init-term() {
	printf '\n' # ensure we have space for the scrollbar
	  printf '\e7' # save the cursor location
	    printf '\e[%d;%dr' 0 "$((LINES - 1))" # set the scrollable region (margin)
	  printf '\e8' # restore the cursor location
	printf '\e[1A' # move cursor up
}

deinit-term() {
	printf '\e7' # save the cursor location
	  printf '\e[%d;%dr' 0 "$LINES" # reset the scrollable region (margin)
	  printf '\e[%d;%dH' "$LINES" 0 # move cursor to the bottom line
	  printf '\e[0K' # clear the line
	printf '\e8' # reset the cursor location
}

main() {
	shopt -s globstar nullglob checkwinsize
	# this line is to ensure LINES and COLUMNS are set
	(:)

	trap deinit-term exit
	trap init-term winch
	init-term

	echo 'searching for files'
	local files=(./*.nim)
	local len=${#files[@]}
	echo "found $len files"

        # if len is zero, fail gracefully
        if ((len == 0)); then
          return
        fi

	local i
	progress-bar "$((i))" "$len"
	for ((i = 0; i < len; i += BATCHSIZE)); do
		process-files "${files[@]:i:BATCHSIZE}"
		progress-bar "$((i+1))" "$len"
	done
	progress-bar "$len" "$len"
}

main "$@"
