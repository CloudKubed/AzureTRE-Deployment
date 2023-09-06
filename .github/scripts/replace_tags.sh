#!/bin/bash

file_path="$1/template_schema.json"

shift 1 # Removes $1 from the parameter list
echo ${pwd}
echo $file_path
i=1
for value in "$@" # Represents the remaining parameters.
do
    echo -e "$value"
    echo -e "custom_tag_key_name_$i"
    sed -i "s/custom_tag_key_name_$i/$value/g" $file_path
    ((i++))
done
