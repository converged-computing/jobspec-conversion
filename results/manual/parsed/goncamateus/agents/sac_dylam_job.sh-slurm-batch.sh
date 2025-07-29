#!/bin/bash
#SBATCH --job-name=sac_dylam_agent
#SBATCH --output=sac_dylam_agent.log
#SBATCH --mail-user=mgm4@cin.ufpe.br
#SBATCH --mail-type=FAIL,END,ARRAY_TASKS
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=1
#SBATCH --mem=24G

module load Python3.10 Xvfb freeglut glew MuJoCo
source $HOME/.pyvenvs/rl/bin/activate
python run_sac_strat.py --cuda --gym-id $1 --total-timesteps 1000000 --num-envs 16 --track --dylam
