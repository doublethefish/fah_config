FILES=$( find . -iname "*.ini" -o -iname "*.h" -o -iname "*.cpp" -o -iname "*.inl" ) #
#FILES=$( git status -uno | ag "modified" | sed 's/modified://' )
for file in ${FILES}; do
	sed --in-place 's/[[:space:]]\+$//' "$file"
done

