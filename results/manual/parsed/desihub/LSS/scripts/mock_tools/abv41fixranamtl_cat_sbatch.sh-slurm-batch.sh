#!/bin/bash
#SBATCH --account=desi
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --qos=regular
#SBATCH --constraint=cpu
#SBATCH --array=1-24

source /global/common/software/desi/users/adematti/cosmodesi_environment.sh main
PYTHONPATH=$PYTHONPATH:$HOME/LSS/py
srun scripts/mock_tools/run1_AMTLmock_LSS_v4_1fixran.sh $SLURM_ARRAY_TASK_ID
