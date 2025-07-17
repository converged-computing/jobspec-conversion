#!/bin/bash
#FLUX: --job-name=dask_srun
#FLUX: -N=4
#FLUX: -n=16
#FLUX: -t=600
#FLUX: --urgency=16

module purge
module load anaconda3/2021.05
conda activate /scratch/jw2636/CMIP6/bgc_md2/prototypes/working_group_2021/yy_cable/bgc_dask_2021.05
conda list
which python
python --version
which conda
conda --version
mpirun --np ${SLURM_NTASKS} python dask_mpirun.py
