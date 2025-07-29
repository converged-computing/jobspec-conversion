#!/bin/bash
#SBATCH --job-name=parpl
#SBATCH --output=parpl.%j.out
#SBATCH --error=parpl.%j.err
#SBATCH --mail-user=hitesh@mpa-garching.mpg.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --time=00:25:00
#SBATCH --partition=p.test
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='1'

set -e
SECONDS=0
module purge
module load ffmpeg/4.4
module list
pip install -e /ptmp/mpa/hitesh/own_package/
cd /ptmp/mpa/hitesh/own_package/own_package/plot/projection_rust/ 
export OMP_NUM_THREADS=1
srun python plot_npy.py $SLURM_CPUS_PER_TASK
echo "Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec"
echo "Boom!"
