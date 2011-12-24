# This file makes list, for each tag, of recent articles, etc.

tag="$1"

echo '<html>
<head>
<title>'
echo "Tag: $tag"
echo '</title>
</head>
<body>
'

echo "<h1> Tag: $tag </h1>"
echo '<ol>'

redo-ifchange "tagindex"
grep "^$(echo "$tag" | sed -e 's/\\/\\\\/g') " "tagindex" | cut -d ' ' -f 2- | sed '1!G;h;$!d' | while read file; do
	redo-ifchange "$file.converted"
	title="$(sed -n 's/Title:[ 	]*\(.*\)/\1/p' < "$file.converted")"
	echo '<li>'
	echo "<h2> <a href='$file.html'>$title</a> </h2>"
	# Now spit out the body
	sed '1,/^$/d' < "$file.converted"
	echo '</li>'
done

echo '</ol>'

echo '</body>
</html>'
