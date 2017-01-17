#!/bin/bash

. /config/filebot.conf

QUOTE_FIXER='replaceAll(/[\`\u00b4\u2018\u2019\u02bb]/, "'"'"'").replaceAll(/[\u201c\u201d]/, '"'"'""'"'"')'
# Used to detect old versions of this script
VERSION=3
# Music/Eric Clapton/From the Cradle/05 - It Hurts Me Too.mp3
MUSIC_FORMAT="Music/{n.$QUOTE_FIXER}/{album.$QUOTE_FIXER}/{media.TrackPosition.pad(2)} - {t.$QUOTE_FIXER}"

# Movies/Fight Club.mkv
MOVIE_FORMAT="Movies/{n.replaceAll(/:\?/,'-').replacePart('')} ({y})/{n.replaceAll(/:\?/,'-').replacePart('')} ({y}) {' - part'+pi}{' ('+fn.match(/Extended/).upper()+')'}[{vf}{'.'+source}{'.'+vc}{'.'+BITDEPTH+'Bit'}{'.'+af}{'.'+ac}{'.'+GROUP}]{'.'+lang}"

# TV Shows/Game of Thrones/Season 05/Game of Thrones - S05E08 - Hardhome.mp4
# TV Shows/Game of Thrones/Special/Game of Thrones - S00E11 - A Day in the Life.mp4
SERIES_FORMAT="TV/{n}/{episode.special ? 'Special' : 'Season '+s.pad(2)}/{n} - {episode.special ? 'S00E'+special.pad(2) : s00e00} - {t.${QUOTE_FIXER}.replaceAll(/[!?.]+$/).replacePart(', Part $1')}{'.'+lang}"

# Download scripts and such.
for SCRIPT_TO_DOWNLOAD in ${SCRIPTS_TO_DOWNLOAD[@]}
do
  FILENAME=/config/scripts/${SCRIPT_TO_DOWNLOAD##*/}

  # Sadly, github doesn't supply a Last-Modified header, so wget -N can't be used. So let's instead only pull down new
  # versions once a day
  if ! test "`find $FILENAME -mtime -1 2>/dev/null`"
  then
    echo Downloading $FILENAME
    wget -q -O $FILENAME $SCRIPT_TO_DOWNLOAD
  fi
done

# See http://www.filebot.net/forums/viewtopic.php?t=215 for details on amc
filebot -script fn:amc -no-xattr --output $OUTPUT_FOLDER --log-file /logs/filebot/amc.log --action $ACTION --conflict auto \
  -non-strict --def ut_dir=$INPUT_FOLDER ut_kind=multi music=$MUSIC deleteAfterExtract=n clean=y \
  excludeList=/config/amc-exclude-list.txt $SUBTITLE_OPTION \
  movieFormat="$MOVIE_FORMAT" musicFormat="$MUSIC_FORMAT" seriesFormat="$SERIES_FORMAT"
