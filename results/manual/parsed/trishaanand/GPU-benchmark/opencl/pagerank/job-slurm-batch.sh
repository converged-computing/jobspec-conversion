#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:30:00
#SBATCH --constraint=TitanX-Pascal

. /etc/bashrc
. /etc/profile.d/modules.sh
module load opencl-nvidia/10.0
./pagerank /var/scratch/alvarban/BSc_2k19/graphs/G500/graph500-23.e /var/scratch/alvarban/BSc_2k19/graphs/G500/graph500-23.v
