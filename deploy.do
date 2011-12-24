
# This takes all .html files and moves them into a folder based on their tag and with sensible file names

# \ becomes / (to allow for hierarchy)

redo-ifchange all

for file in *.html; do
	dir="$(echo "$file" | sed 's/.*\.\([^.]*\)\.html$/\1/' | tr '\\' '/')"
	basename="${file##*.}"
	mkdir -p "$dir"
	cp -p "$file" "$dir/$basename.html"
done

# And move the index files in too
for file in *.tagindex; do
	dir="$(basename "$file" .tagindex | tr '\\' '/')"
	mkdir -p "$dir"
	cp -p "$file" "$dir/index.html"
done

# And move the feed files in too
for file in *.tagfeed; do
	dir="$(basename "$file" .tagfeed | tr '\\' '/')"
	mkdir -p "$dir"
	cp -p "$file" "$dir/index.atom"
done
