
# I'm a little upset how much knowledge all.do has to have into how to name the files, but I haven't come up with a better way

ls *.mime | while read file; do
	dependedFile="$file.augmented.html"
	sed -n '/^Tag:/s/^Tag:[^a-zA-Z0-9_-]*\([a-zA-Z0-9_-]*\).*/\1/p' < "$file" | while read tag; do echo "$dependedFile.$tag.tag"; done  | xargs redo-ifchange
done
