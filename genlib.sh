#!/bin/bash

RDF=cache
LIB=lib
DEST=mp3

# Use the following on this to find all languages:
# grep -rhF 'RFC4646' cache | sed 's/.*>\(.*\)<.*/\1/' | sort | uniq -c | sort -n

LANGS="en fr fi de nl it es pt el sv hu la da pl"
FILESPERLANG=10
LINECOUNT=500

WPMS="14 16 18 20 22 24" # Character speeds
EWPMS="9 10 11 12 13 14 15 16" # Effective speeds
FREQ=700               # Tone frequency
DURATION=240           # Number of seconds (finishes sentence)
AUTHOR="Camil PD7LOL"  # MP3 author
TITLE="Random CW text" # MP3 title
ALBUM="Random CW text" # MP3 album title (WPM is appended)
FILENAME="books"       # MP3 filename (number and .mp3 is appended)

if [ "$1" == "new" ]; then
	if [ ! -d "$RDF" ]; then
		curl http://www.gutenberg.org/cache/epub/feeds/rdf-files.tar.bz2 \
			| tar xj
	fi

	mkdir -p "$LIB"
	for lang in $LANGS; do
		echo "Downloading books for language: $lang"
		targets="$(grep -rFl "RFC4646\">$lang" "$RDF" | cut -d/ -f3 | shuf -n $FILESPERLANG)"
		for t in $targets; do
			echo "$t"
			curl -Ls "http://www.gutenberg.org/ebooks/$t.txt.utf-8" > "$LIB/$t.txt"
		done
	done
fi

for WPM in $WPMS; do
	for EWPM in $EWPMS; do
		rm -f "$LIB/all.txt"
		cat "$LIB/"*.txt | grep -v '^[[:space:]]*$' | shuf -n $LINECOUNT > "$LIB/all.txt"
		
		RDEST="$DEST-$WPM-$EWPM"
		rm -rf "$RDEST"
		mkdir -p "$RDEST"
		ebook2cw -w $WPM -e $EWPM -f $FREQ -d $DURATION -u \
			-a "$AUTHOR" -t "$TITLE" -o "$RDEST/$FILENAME"\
			"$LIB/all.txt"
		id3v2 -A "$ALBUM ($WPM/$EWPM wpm)" "$RDEST/"*.mp3
	done
done
