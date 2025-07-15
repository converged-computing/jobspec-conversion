#!/bin/bash
#FLUX: --job-name=swampy-snack-5648
#FLUX: -t=600
#FLUX: --urgency=16

module load perl/5.22.1
echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
module load slim/3.1
scenarioID=$1
declare -i repID=$SLURM_ARRAY_TASK_ID
mkdir /scratch/pjohri1/ModelRejection/PosteriorChecks/eqm_pos_selection/scenario$scenarioID
cd /home/pjohri1/ModelRejection/PosteriorChecks
python make_command_file_pos.py -scenarioNum $scenarioID -repNum $repID -outFolder /scratch/pjohri1/ModelRejection/PosteriorChecks/eqm_pos_selection/bash_files
bash /scratch/pjohri1/ModelRejection/PosteriorChecks/eqm_pos_selection/bash_files/scenario${scenarioID}_rep${repID}.sh
