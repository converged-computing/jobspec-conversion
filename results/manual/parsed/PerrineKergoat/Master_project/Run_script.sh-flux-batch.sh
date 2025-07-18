#!/bin/bash
#FLUX: --job-name=Isl_mod
#FLUX: -t=54000
#FLUX: --urgency=16

module load gcc
module load slim/4.0.1
module load python
module load r
source /work/FAC/FBM/DEE/jgoudet/default/pkergoat/pyslim_venv/bin/activate
echo "Lancement script 1"
slim -d job_id=$SLURM_ARRAY_JOB_ID -d rep_nb=$SLURM_ARRAY_TASK_ID -d nb_pop=$1 -d sel_coeff=$2 -d recomb_rate=$3 Sim_2pop_1sel.slim
echo "Fin script 1"
echo "Lancement script 2"
python ./Recapitation.py $SLURM_ARRAY_JOB_ID  $SLURM_ARRAY_TASK_ID $3
echo "Fin script 2"
echo "Lancement script 3"
Rscript ./Comparison.R $SLURM_ARRAY_JOB_ID $SLURM_ARRAY_TASK_ID
echo "Fin script 3"
