#!/bin/bash
#FLUX: --job-name="Collect NAMD Energy"
#FLUX: --priority=16

module load vmd
names=()
while IFS= read -r line; do
	names+=("$line")
done < "names.txt"
for element in "${names[@]}"; do
	cd $element
	cp ../get_NAMDenergy.vmd .
	vmd -dispdev text -e get_NAMDenergy.vmd >> get_NAMDenergy.log
	cd ..
done
