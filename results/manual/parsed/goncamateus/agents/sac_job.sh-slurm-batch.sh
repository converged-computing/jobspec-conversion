#!/bin/bash
#SBATCH --job-name=sac_agent
#SBATCH --output=sac_agent.log
#SBATCH --mail-user=mgm4@cin.ufpe.br
#SBATCH --mail-type=FAIL,END,ARRAY_TASKS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=1
#SBATCH --mem=24G
#SBATCH --partition=short

module load Python3.10 Xvfb freeglut glew MuJoCo
source $HOME/.pyvenvs/rl/bin/activate
python run_sac.py --cuda --gym-id $1 --total-timesteps 1000000 --num-envs 16 --track
