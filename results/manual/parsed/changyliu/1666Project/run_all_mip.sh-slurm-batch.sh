#!/bin/bash
#SBATCH --account=rrg-khalile2
#SBATCH --output=%N-%j.out
#SBATCH --mail-user=changy.liu@mail.utoronto.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=15:59:00

echo "Running on Graham cluster"
module load python/3.8
source /home/liucha90/chang_pytorch/bin/activate
python3.8 runMIPall.py --dataset_name "${dataset_name:="1PDPTW_generated_d21_i1000_tmin300_tmax500_sd2022_test"}"
