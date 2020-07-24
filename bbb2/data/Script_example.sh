#/bin/bash

folder=$1
metadata=$2
suffix= "JPG"

find ${folder} -type f -name "*$suffix*"

for file in $(find ${folder} -type f -name "*${suffix}*"); do
  mv ${file} ${file%.*}.${suffix}
done

find ${folder} -type f -name "*.${suffix}" | rename 's/\.${suffix}$/.jpg/'

find ${folder} -type f -name "*.jpg" > File_names.txt

#Write while loop to move files to a common folder
mkdir Common_folder
while read line; do
  mv ${line} Common_folder
done<File_names.txt

sed -i -e 's/A//g' -e 's/B//g' -e 's/C//g'

ls Common_folder -1 | sort > File_names_sorted.txt
sort ${metadata} | paste File_names_sorted.txt > metadata_with_paths.txt


while read line; do
  #move to the categories


done<metadata_with_paths.txt
