#!/bin/bash
#SBATCH --job-name=Collect NAMD Energy
#SBATCH --account=p31412
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --partition=short
#SBATCH --constraint=ntasks-per-node=1

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
