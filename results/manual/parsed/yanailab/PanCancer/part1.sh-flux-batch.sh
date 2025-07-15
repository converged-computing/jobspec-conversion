#!/bin/bash
#FLUX: --job-name=Gyn_part1
#FLUX: -c=40
#FLUX: --queue=cpu_short
#FLUX: -t=36000
#FLUX: --urgency=16

source ~/.bashrc
if [ "$#" == 3 ]; then
	cd ~/Documents/STARCH
	conda activate STARCH
	python run_STARCH.py -i ~/Documents/Gyn/${1}${2}/${1}${2}${3}/Clones --output Clones --n_clusters 3 --outdir ~/Documents/Gyn/${1}${2}/${1}${2}${3}/Clones
	conda deactivate
	cd ~/Documents/Gyn/${1}${2}/${1}${2}${3}
	conda activate seurat_functions
	module load r/4.0.3
	Rscript ~/Documents/Gyn/Runs/part1.R ${1} ${2} ${3}
elif [ "$#" == 4 ]; then
	cd ~/Documents/STARCH
	conda activate STARCH
	python run_STARCH.py -i ~/Documents/Gyn/${1}${2}${3}/${1}${2}${3}${4}/Clones --output Clones --n_clusters 3 --outdir ~/Documents/Gyn/${1}${2}${3}/${1}${2}${3}${4}/Clones
	conda deactivate
	cd ~/Documents/Gyn/${1}${2}${3}/${1}${2}${3}${4}
	conda activate seurat_functions
	module load r/4.0.3
	Rscript ~/Documents/Gyn/Runs/part1.R ${1} ${2} ${3} ${4}
fi
