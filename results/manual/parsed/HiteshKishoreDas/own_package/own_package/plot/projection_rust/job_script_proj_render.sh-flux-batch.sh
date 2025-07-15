#!/bin/bash
#FLUX: --job-name=buttery-fudge-9314
#FLUX: -c=40
#FLUX: --queue=p.test
#FLUX: -t=1500
#FLUX: --urgency=16

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
