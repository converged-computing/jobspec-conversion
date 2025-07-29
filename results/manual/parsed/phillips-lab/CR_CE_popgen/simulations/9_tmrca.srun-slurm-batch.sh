#!/bin/bash
#FLUX: --job-name=tmrca
#FLUX: --queue=phillips
#FLUX: -t=54000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
treeh="/projects/phillipslab/ateterina/slim/worms_snakemake/tree_heights_table.py"
cd sim30rep # and others
listfiles=(*.trees)
	file=${listfiles[$SLURM_ARRAY_TASK_ID]}
	python3 $treeh -t $file >${file/trees/TREE_HEIGH}
