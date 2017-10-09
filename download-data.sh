#!/bin/bash

function fileExists {
if [ -f $1 ]; then
  return 0
fi
return 1
}

data=(
    "people.json"
    "m201/how_data_is_stored_on_disk.sh"
    "m201/single_field_indexes_part_1.js"
    "m201/single_field_indexes_part_1.sh"
    "m201/single_field_indexes_part_2.js"
    "m201/sorting_with_indexes.js"
    "m201/sorting_with_indexes.sh"
    "m201/when_you_can_sort_with_indexes.js"
    "m201/multikey_indexes.js"
    "m201/partial_indexes.js"
    "m201/collations.js"
    "restaurants.json.zip"
    "m201/building_indexes.js"
    "m201/building_indexes.sh"
    "m201/understanding_explain_part_1.js"
    "m201/understanding_explain_part_2.js"
    "m201/understanding_explain_part_2.sh"
)

URL="https://university.mongodb.com/static/MongoDB_2017_M201_September/handouts"


for i in "${data[@]}"
do
    if ! fileExists "./data/$i"; then
        wget $URL/$i --output-document="./data/$i"
    fi
done
