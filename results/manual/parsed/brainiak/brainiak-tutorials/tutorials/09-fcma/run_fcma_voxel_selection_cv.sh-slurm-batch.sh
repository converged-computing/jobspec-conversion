#!/bin/bash
#SBATCH --job-name=fcma_voxel_select_cv
#SBATCH --output=../logs/fcma_voxel_select_cv-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8G
#SBATCH --time=00:20:00

export OMP_NUM_THREADS='32'

source ../setup_environment.sh
export OMP_NUM_THREADS=32
currentdir=`pwd`
data_dir=$1  # What is the directory containing data?
suffix=$2  # What is the extension of the data you're loading
mask_file=$3  # What is the path to the whole brain mask
epoch_file=$4  # What is the path to the epoch file
left_out_subj=$5  # Which participant (as an integer) are you leaving out for this cv?
output_dir=$6 # Where do you want to save the data
if [ $configuration == "cluster" ]
then
	srun --mpi=pmi2 python ./fcma_voxel_selection_cv.py $data_dir $suffix $mask_file $epoch_file $left_out_subj $output_dir
else
	mpirun -np 2 python ./fcma_voxel_selection_cv.py $data_dir $suffix $mask_file $epoch_file $left_out_subj $output_dir
fi
