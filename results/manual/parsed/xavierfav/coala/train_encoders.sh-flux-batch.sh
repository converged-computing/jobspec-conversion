#!/bin/bash
#FLUX: --job-name=rep-learning
#FLUX: --queue=gpu
#FLUX: -t=252000
#FLUX: --priority=16

printf "[----]\n"
printf "Starting execution of job $SLURM_JOB_ID from user $LOGNAME\n"
printf "Starting at `date`\n"
start=`date +%s`
module load python-env/2019.3
module load pytorch/1.3.0
source venv/bin/activate
pip install tensorboard
srun python train_dual_ae.py 'configs/dual_e_c.json'
end=`date +%s`
printf "\n[----]\n"
printf "Job done. Ending at `date`\n"
runtime=$((end-start))
printf "It took: $runtime sec.\n"
