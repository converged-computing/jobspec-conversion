#!/bin/bash
#SBATCH --job-name=mise_a_jour_TRUST_arch
#SBATCH --output=/home/triou/myjob_callisto-intel.%j.o
#SBATCH --error=/home/triou/myjob_callisto-intel.%j.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --qos=normal

set -x
cd $SLURM_SUBMIT_DIR
[ -f ld_env.sh ] && . ./ld_env.sh # To load an environment file if necessary
srun -n $SLURM_NTASKS ./mise_a_jour_TRUST_arch 1>~/CR_callisto-intel 2>&1 
