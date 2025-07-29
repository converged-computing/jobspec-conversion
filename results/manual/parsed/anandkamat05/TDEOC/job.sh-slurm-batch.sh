#!/bin/bash
#SBATCH --account=rpp-bengioy
#SBATCH --output=./OUT/tabular-%j.out
#SBATCH --mail-user=anand.kamat@mail.mcgill.ca
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:2
#SBATCH --mem=15G
#SBATCH --time=1-00:00:00

module load python/3.6
module load cuda cudnn 
source ~/PPOC_gpu/bin/activate
python ./baselines/ppo1/run_mujoco.py --saves --opt=4 --minibatch=200 --dc=0.1 --tradeoff=0.01 --prew_control=1e3 --caption='' --diayn --seed=11
