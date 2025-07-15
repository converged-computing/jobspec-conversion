#!/bin/bash
#FLUX: --job-name=snap_array_job
#FLUX: -c=4
#FLUX: --queue=small
#FLUX: -t=7200
#FLUX: --urgency=16

module load snap
readlink -f /appl/data/geo/sentinel/s2_example_data/L2A/S2* > image_path_list.txt
image_path=$(sed -n ${SLURM_ARRAY_TASK_ID}p image_path_list.txt)
image_filename="$(basename -- $image_path)"
output_folder=/scratch/project_2000599/snap/output/
singularity_wrapper exec gpt_array /scratch/project_2000599/snap/tmp_snap_userdir_"$SLURM_ARRAY_TASK_ID" resample_and_LAI.xml -q 4 -t ${output_folder}/${image_filename}_LAI.tif -SsourceProduct=${image_path}/MTD_MSIL2A.xml
