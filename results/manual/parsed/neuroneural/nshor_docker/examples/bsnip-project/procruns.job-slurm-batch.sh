#!/bin/bash
#SBATCH --job-name=PRPbsnip
#SBATCH --account=psy53c17
#SBATCH --output=/data/users2/jwardell1/nshor_docker/examples/bsnip-project/jobs/out%A_%a.out
#SBATCH --error=/data/users2/jwardell1/nshor_docker/examples/bsnip-project/jobs/error%A_%a.err
#SBATCH --mail-user=jwardell1@student.gsu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=64g
#SBATCH --time=20:00:00

sleep 5s
module load singularity/3.10.2
SUB_PATHS_FILE=/data/users2/jwardell1/nshor_docker/examples/bsnip-project/BSNIP/Boston/paths
SIF_FILE=/data/users2/jwardell1/nshor_docker/fmriproc.sif
IFS=$'\n'
paths_array=($(cat ${SUB_PATHS_FILE}))
func_ix=$(( 3*$SLURM_ARRAY_TASK_ID ))
anat_ix=$(( 3*$SLURM_ARRAY_TASK_ID + 1 ))
out_ix=$(( 3*$SLURM_ARRAY_TASK_ID + 2 ))
func_filepath=${paths_array[${func_ix}]}
anat_filepath=${paths_array[${anat_ix}]}
out_bind=${paths_array[${out_ix}]}
func_bind=`dirname $func_filepath`
anat_bind=`dirname $anat_filepath`
func_file=`basename $func_filepath`
anat_file=`basename $anat_filepath`
singularity exec --writable-tmpfs --bind $func_bind:/func,$anat_bind:/anat,$out_bind:/out $SIF_FILE /main.sh -f $func_file -a $anat_file -o $out_bind &
wait
sleep 10s
