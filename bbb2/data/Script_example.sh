#/bin/bash

folder="${1}"
metadata="${2}"
suffix="JPG"

## Print to screen all the original files
find ${folder} -type f -name "*${suffix}*"

## Rename each file to remove unneccessary suffixes
for file in $(find ${folder} -type f -name "*${suffix}*"); do
  ## Leave behind some echos for future troubleshooting
  # echo ${file}
  # echo ${file%%.*}
  # echo ''
  mv ${file} ${file%%.*}.${suffix}
done

## Make the suffix JPG lowercase on all files. This step could be merged with the previous step too.
find ${folder} -type f -name "*.${suffix}" | rename "s/\.${suffix}$/.jpg/"

## Save the list of new filepaths in File_names.txt
find ${folder} -type f -name "*.jpg" > File_names.txt

#Write while loop to move files to a common folder. This could be done with a for loop too.
mkdir Common_folder
while read line; do
  mv ${line} Common_folder
done < File_names.txt

## Edit the contents of the metadata file to get correct category names
sed -i -e 's/\tA\t/\tdog\t/' -e 's/\tB\t/\tcat\t/' -e 's/\tC\t/\tbird\t/' ${metadata}

## Sort the file names in Common_filder and the lines of the metadata file, and paste the two files side by side.
## This creates a file with both the path and the metadata for each file, one file per line.
ls Common_folder -1 | sort > File_names_sorted.txt
sort ${metadata} | paste File_names_sorted.txt - >metadata_with_paths.txt

## Finally, read the metadata and sort your images into different (sub)directories
while read line; do
  ## First, parse the line contents into different variables
  file_path=$(echo ${line} | cut -d " " -f1)
  main_category=$(echo ${line} | cut -d " " -f3)
  secondary_category=$(echo ${line} | cut -d " " -f4)
  ## Leftover echos from the script development and for future troubleshooting
  # echo ${file_path}
  # echo $main_category
  # echo $secondary_category
  # echo ''
  
  ## Make the directory if it doesn't exist
  mkdir -p Common_folder/${main_category}/${secondary_category}/
  
  ## Move the image in its corresponding directory
  mv Common_folder/${file_path} Common_folder/${main_category}/${secondary_category}/
done < metadata_with_paths.txt
