#!/bin/bash
#SBATCH --job-name=dtan_job
#SBATCH --output=logs/job-%J.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=rtx_3090:1
#SBATCH --mem=40G
#SBATCH --time=7-00:00:00
#SBATCH --qos=orenfr
#SBATCH --array=1

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/home/avihaina/.conda/envs/torch_env/lib/'
export PATH='/opt/rh/devtoolset-9/root/usr/bin/:$PATH'

scl enable devtoolset-9 bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/avihaina/.conda/envs/torch_env/lib/
export PATH=/opt/rh/devtoolset-9/root/usr/bin/:$PATH
which gcc
gcc --version
echo `date`
echo -e "\nSLURM_JOBID:\t\t" $SLURM_JOBID
echo -e "SLURM_JOB_NODELIST:\t" $SLURM_JOB_NODELIST "\n\n"
module load anaconda                            ### load anaconda module (must be present when working with conda environments)
module load cuda/11.4
module load anaconda
source activate torch_env                               ### activate a conda environment, replace my_env with your conda environment
conda env list
python -m torch.utils.collect_env
cd  /home/avihaina/jupyter_project/superVit/
python  train.py --n_epochs=200
python evaluate.py 
