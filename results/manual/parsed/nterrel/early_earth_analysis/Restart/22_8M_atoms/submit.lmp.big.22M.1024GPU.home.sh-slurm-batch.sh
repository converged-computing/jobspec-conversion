#!/bin/bash
#SBATCH --job-name=lammps_ani
#SBATCH --account=roitberg
#SBATCH --output=lammps_ani_22M_1024gpu_%j.log
#SBATCH --mail-user=jinzexue@ufl.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=124
#SBATCH --ntasks=992
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8
#SBATCH --mem-per-cpu=120gb
#SBATCH --time=8-08:00:00
#SBATCH --qos=roitberg
#SBATCH --constraint=ntasks-per-node=8
#SBATCH --exclude=c0900a-s11

export LAMMPS_ANI_ROOT='/home/jinzexue/program/lammps-ani'
export LAMMPS_ROOT='${LAMMPS_ANI_ROOT}/external/lammps/'
export LAMMPS_PLUGIN_PATH='${LAMMPS_ANI_ROOT}/build/'

echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
module load cuda/11.4.3 gcc/9.3.0 openmpi/4.1.5 cmake/3.21.3 git/2.30.1 
export LAMMPS_ANI_ROOT="/home/jinzexue/program/lammps-ani"
export LAMMPS_ROOT=${LAMMPS_ANI_ROOT}/external/lammps/
export LAMMPS_PLUGIN_PATH=${LAMMPS_ANI_ROOT}/build/
source $(conda info --base)/etc/profile.d/conda.sh
conda activate /home/jinzexue/program/torch1121 
echo using python: $(which python)
python run_one.py \
       	data/mixture_22800000.data \
       	--kokkos \
	--num_gpus=992 \
	--input_file=in.22M.restart7.lammps \
	--log_dir=/red/roitberg/22M_20231222_prodrun \
	--ani_model_file='ani1x_nr.pt' \
	--run_name=early_earth_22M \
	--ani_num_models=8 \
	--timestep=0.25 \
	--run
