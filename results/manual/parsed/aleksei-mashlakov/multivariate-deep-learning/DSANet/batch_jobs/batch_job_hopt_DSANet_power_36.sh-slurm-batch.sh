#!/bin/bash
#SBATCH --job-name=dsap4hopt
#SBATCH --account=Project_2002244
#SBATCH --output=job_out_ep_4_power_168_36_hopt_f4.txt
#SBATCH --error=job_err_ep_4_power_168_36_hopt_f4.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:v100:4
#SBATCH --mem=32G
#SBATCH --time=2-00:59:00
#SBATCH --partition=gpu

module load gcc/8.3.0 cuda/10.1.168
module load pytorch/1.3.0
module list
echo "Installing requirements ..."
pip install -r 'requirements.txt' --user -q --no-cache-dir
echo "Requirements installed."
echo "Start running ... "
srun python3 hopt_gpu_trainer_power.py --data_name europe_power_system --window 168 --n_multiv 183 --horizon 36 --split_train 0.11267605633802817 --split_validation 0.02910798122065728 --split_test 0.02910798122065728
echo "Finished running!"
seff $SLURM_JOBID
