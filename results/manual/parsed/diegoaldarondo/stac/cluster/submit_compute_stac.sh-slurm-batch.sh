#!/bin/bash
#SBATCH --job-name=compute_stac
#SBATCH --output=logs/Job.compute_stac.%N.%j.out
#SBATCH --error=logs/Job.compute_stac.%N.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=3000
#SBATCH --time=00:00:45

img_path="/n/home02/daldarondo/LabDir/Diego/.images/mj_stac.sif"
param_path=$1; shift
save_path=$1; shift
offset_path=$1; shift
data_path=( "$@" )
echo singularity exec $img_path bash /home/compute_stac.sh ${data_path[$SLURM_ARRAY_TASK_ID]} $param_path $save_path $offset_path
singularity exec $img_path bash /home/compute_stac.sh ${data_path[$SLURM_ARRAY_TASK_ID]} $param_path $save_path $offset_path
