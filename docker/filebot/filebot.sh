#!/bin/bash

# This script by default uses "Automated Media Center" (AMC). See the final filebot call below. For more docs on AMC,
# visit: http://www.filebot.net/forums/viewtopic.php?t=215

export LC_ALL="en_US.UTF-8"

. /config/filebot.conf

QUOTE_FIXER='replaceAll(/[\`\u00b4\u2018\u2019\u02bb]/, "'"'"'").replaceAll(/[\u201c\u201d]/, '"'"'""'"'"')'
# Used to detect old versions of this script
VERSION=3

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
filebot -script fn:amc -no-xattr --output $OUTPUT_FOLDER --log-file /config/amc.log --action $ACTION --conflict auto \
  -non-strict --def ut_dir=$INPUT_FOLDER ut_kind=multi music=y deleteAfterExtract=n clean=y \
  excludeList=/config/amc-exclude-list.txt $SUBTITLE_OPTION \
  movieFormat="$MOVIE_FORMAT" musicFormat="$MUSIC_FORMAT" seriesFormat="$SERIES_FORMAT"
