#!/bin/bash
#SBATCH --job-name=firedrake
#SBATCH --account=your_account
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=standard
#SBATCH --qos=standard

export FIREDRAKE_DIR='/your/firedrake/install/dir'
export FI_OFI_RXM_SAR_LIMIT='64K'

export FIREDRAKE_DIR=/your/firedrake/install/dir
myScript=example.py
export FI_OFI_RXM_SAR_LIMIT=64K
module load epcc-job-env
source $FIREDRAKE_DIR/firedrake_activate.sh
srun --ntasks-per-node 1 $FIREDRAKE_DIR/firedrake_activate.sh
srun --ntasks-per-node 128 $VIRTUAL_ENV/bin/python ${myScript}
