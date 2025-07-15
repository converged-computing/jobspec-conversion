#!/bin/bash
#FLUX: --job-name=peleffy
#FLUX: -n=2
#FLUX: -t=1800
#FLUX: --priority=16

module purge
module load anaconda
module load intel impi mkl boost cmake transfer bsc
eval "$(conda shell.bash hook)"
conda activate /gpfs/projects/bsc72/conda_envs/platform/1.6.3
python -m peleffy.main ligand_to_parametrize.pdb -f OPLS2005
