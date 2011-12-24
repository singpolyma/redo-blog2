
# This is meant to use metadata from git, or hg, or the filesystem, or whatever to augment the user-given metadata
# It's meant to fill in all the auto-generatable blanks
# This implementation gets data from git.

redo-ifchange "$1.mime"

times="$(git log --pretty=format:%ai "$1.mime")"

# This is the first time the file was added
create_time="$(echo "$times" | sed -n '$p' | sed -e 's/ /T/' | tr -d ' ')"
if [ -n "$create_time" ]; then
	echo "Date-Created: $create_time"
	year="$(echo $create_time | sed -e 's/^\(....\).*/\1/')"
	month="$(echo $create_time | sed -e 's/^....-\?\(..\).*/\1/')"
	echo "Tag: $year $year\\$month"
fi

# This is the last time a change was made
modify_time="$(echo "$times" | sed -n '1p' | sed -e 's/ /T/' | tr -d ' ')"
if [ -n "$modify_time" ]; then
	echo "Date-Modified: $modify_time"
fi

cat "$1.mime"
