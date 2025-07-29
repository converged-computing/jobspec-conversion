#!/bin/bash
#SBATCH --job-name=Collect NAMD Energy
#SBATCH --account=p31412
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1

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
