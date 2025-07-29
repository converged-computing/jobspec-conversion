#!/bin/bash
#SBATCH --job-name=cluster_i_2
#SBATCH --output=/home/users/l/lorenz-08-15/activelearning_ic/cluster_outputs/cluster_image_2.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --time=16:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --chdir=/home/users/l/lorenz-08-15/activelearning_ic/

if [ ! "$HOSTNAME" == "frontend*" ]; then
 export https_proxy="http://frontend01:3128/"
 export http_proxy="http://frontend01:3128/"
 echo "HTTP proxy set up done"
fi
module load nvidia/cuda/11.2
srun python main.py --batch_size 12 --max_cycles 9 --epochs 10 --run_name cluster_image_2 --sample_method cluster --cluster_mode image --seed 2
