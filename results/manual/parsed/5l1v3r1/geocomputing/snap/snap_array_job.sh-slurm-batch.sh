#!/bin/bash
#SBATCH --job-name=snap_array_job
#SBATCH --account=<INSERT-YOUR-PROJECT>
#SBATCH --output=out_%A_%a.txt
#SBATCH --error=err_%A_%a.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=2000
#SBATCH --time=02:00:00
#SBATCH --array=1-3

module load snap
readlink -f /appl/data/geo/sentinel/s2_example_data/L2A/S2* > image_path_list.txt
image_path=$(sed -n ${SLURM_ARRAY_TASK_ID}p image_path_list.txt)
image_filename="$(basename -- $image_path)"
output_folder=/scratch/project_2000599/snap/output/
singularity_wrapper exec gpt_array /scratch/project_2000599/snap/tmp_snap_userdir_"$SLURM_ARRAY_TASK_ID" resample_and_LAI.xml -q 4 -t ${output_folder}/${image_filename}_LAI.tif -SsourceProduct=${image_path}/MTD_MSIL2A.xml
