#!/bin/bash
#SBATCH --job-name=dog_gaussian_reward
#SBATCH --output=./jobs/gaussian_reward.out
#SBATCH --error=./jobs/gaussian_reward.err
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2000
#SBATCH --time=16:00:00

module load gcc/8.2.0 python/3.9.9 cmake/3.25.0 freeglut/3.0.0 libxrandr/1.5.0  libxinerama/1.1.3 libxi/1.7.6  libxcursor/1.1.14 mesa/17.2.3 eth_proxy
conda activate pylocoEnv
xvfb-run -a --server-args="-screen 0 480x480x24" python3 src/python/main.py -wb -vr -c dog_gaussian_env.json --rewardFile=./dog/gaussian_reward.py
