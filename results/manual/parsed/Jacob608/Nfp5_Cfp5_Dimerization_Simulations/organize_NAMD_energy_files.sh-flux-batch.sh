#!/bin/bash
#FLUX: --job-name="Collect NAMD Energy"
#FLUX: --priority=16

module load vmd
names=()
while IFS= read -r line; do
	names+=("$line")
done < "names.txt"
mkdir all_namd_energies
for element in "${names[@]}"; do
	cd $element
	cp namdenergy.csv namdenergy_$element.csv
	mv namdenergy_$element.csv ../all_namd_energies
	cd ..
done
