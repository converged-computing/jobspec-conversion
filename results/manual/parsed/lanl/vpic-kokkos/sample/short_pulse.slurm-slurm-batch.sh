#!/bin/bash
#SBATCH --job-name=short_pulse
#SBATCH --account=my_account
#SBATCH --output=short_pulse%j.out
#SBATCH --error=short_pulse%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=16:00:00
#SBATCH --qos=standard

module purge
module load PrgEnv-cray
module load cmake
module list
pwd
date
ls -lh
echo '*** Starting Parallel Job ***'
srun -n $SLURM_NTASKS ./short_pulse.Linux
date
echo '*** All Done ***'
