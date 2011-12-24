
# This is meant to take the mime files and run them through this tag's template engine to get static html files
# It also fills in some per-tag info

tag="${1##*.}"
base="$(basename "$1" ".$tag")"
dependedFile="$base.converted"

redo-ifchange "$dependedFile" "$tag.tagtemplate" "tagindex"

# Find our position for our tag in the index
taglist="$(grep "^$(echo "$tag" | sed -e 's/\\/\\\\/g') " tagindex)"
pos="$(echo "$taglist" | grep -n " $base\$" | cut -d ':' -f 1)"

if [ "$pos" -gt 1 ]; then 
	prev="$(echo "$taglist" | sed -n "$(( $pos - 1 ))"p | cut -d ' ' -f2-)"
else
	prev=""
fi

# Sed returns "" for me when I walk off the edge of the file
next="$(echo "$taglist" | sed -n "$(( $pos + 1 ))"p | cut -d ' ' -f2-)"

(
	echo "Next-Link: $next"
	echo "Previous-Link: $prev"
	cat "$dependedFile"
) | "./$tag.tagtemplate"
