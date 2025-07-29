#!/bin/bash
#FLUX: --job-name=DeepSphere_climate_equi
#FLUX: -c=12
#FLUX: --queue=normal
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load daint-gpu
module load cray-python/3.6.5.1
module load TensorFlow/1.11.0-CrayGNU-18.08-cuda-9.1-python3
module load PyExtensions/3.6.5.1-CrayGNU-18.08
module load h5py/2.8.0-CrayGNU-18.08-python3-serial
source ~/venv-3.6/bin/activate
cd $SCRATCH/PDMdeepsphere/Experiments/Climate
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
srun -n 1 -u python run_experiment_equiangular.py
echo -e "$SLURM_JOB_NAME finished on $(date)\n"
