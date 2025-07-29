#!/bin/bash
#SBATCH --job-name=tmrca
#SBATCH --account=phillipslab
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=15:00:00
#SBATCH --partition=phillips
#SBATCH --array=0-2400%140

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
treeh="/projects/phillipslab/ateterina/slim/worms_snakemake/tree_heights_table.py"
cd sim30rep # and others
listfiles=(*.trees)
	file=${listfiles[$SLURM_ARRAY_TASK_ID]}
	python3 $treeh -t $file >${file/trees/TREE_HEIGH}
