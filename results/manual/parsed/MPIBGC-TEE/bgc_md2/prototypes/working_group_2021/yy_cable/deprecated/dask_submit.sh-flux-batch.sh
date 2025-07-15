#!/bin/bash
#FLUX: --job-name=dask_exp
#FLUX: -N=2
#FLUX: -n=2
#FLUX: -c=5
#FLUX: -t=600
#FLUX: --priority=16

module purge
module load anaconda3/2020.11
conda activate /scratch/jw2636/CMIP6/bgc_md2/prototypes/working_group_2021/yy_cable/dask
conda list
which python
python --version
which conda
conda --version
srun --overcommit \
     --distribution=cyclic \
	 --nodes=${SLURM_NNODES} \
	 --ntasks=$[SLURM_NTASKS+2] \
	 --cpus-per-task=${SLURM_CPUS_PER_TASK} \
	 python dask_example.py
