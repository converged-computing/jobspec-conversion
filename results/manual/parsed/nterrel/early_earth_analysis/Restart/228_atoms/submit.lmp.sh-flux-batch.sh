#!/bin/bash
#FLUX: --job-name=lammps_ani
#FLUX: --queue=hpg-ai
#FLUX: -t=28800
#FLUX: --urgency=16

export LAMMPS_ANI_ROOT='/blue/roitberg/apps/lammps-ani'
export LAMMPS_ROOT='${LAMMPS_ANI_ROOT}/external/lammps/'
export LAMMPS_PLUGIN_PATH='${LAMMPS_ANI_ROOT}/build/'

echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
module load cuda/11.4.3 gcc/9.3.0 openmpi/4.0.5 cmake/3.21.3 git/2.30.1 netcdf/4.7.2
export LAMMPS_ANI_ROOT="/blue/roitberg/apps/lammps-ani"
export LAMMPS_ROOT=${LAMMPS_ANI_ROOT}/external/lammps/
export LAMMPS_PLUGIN_PATH=${LAMMPS_ANI_ROOT}/build/
source $(conda info --base)/etc/profile.d/conda.sh
conda activate /blue/roitberg/apps/torch1121
echo using python: $(which python)
python run_228.py mixture_228.data --kokkos --num_gpus=2 --input_file=in.lammps --log_dir=logs --ani_model_file='ani1x_nr.pt' --run_name=scale_early_earth_ani1x_nr --ani_num_models=-1 --timestep=0.25 --run
