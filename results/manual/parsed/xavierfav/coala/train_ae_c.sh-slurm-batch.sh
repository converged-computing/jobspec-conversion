#!/bin/bash
#SBATCH --job-name=rep-learning
#SBATCH --account=asignal
#SBATCH --output=/scratch/asignal/favoryxa/out/%J.%u.out
#SBATCH --error=/scratch/asignal/favoryxa/out/%J.%u.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=12000
#SBATCH --time=2-22:00:00

printf "[----]\n"
printf "Starting execution of job $SLURM_JOB_ID from user $LOGNAME\n"
printf "Starting at `date`\n"
start=`date +%s`
module load python-env/2019.3
module load pytorch/1.3.0
source venv/bin/activate
pip install tensorboard
srun python train_dual_ae.py 'configs/dual_ae_c.json'
end=`date +%s`
printf "\n[----]\n"
printf "Job done. Ending at `date`\n"
runtime=$((end-start))
printf "It took: $runtime sec.\n"
