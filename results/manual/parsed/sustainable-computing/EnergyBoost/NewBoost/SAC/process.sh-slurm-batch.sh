#!/bin/bash
#SBATCH --job-name=SAC
#SBATCH --output=%N-%j.out
#SBATCH --error=%N-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=32000M
#SBATCH --time=00:14:00

module load python/3.6.3
module load scipy-stack
virtualenv --no-download ~/ENV
source ~/ENV/bin/activate
pip install torch --no-index
pip install tqdm
for i in 59
do
  python main.py 0.2 6.4 2 ../data/added_hhdata_"$i"_2.csv
  python main.py 0.2 13.5 5 ../data/added_hhdata_"$i"_2.csv
  python main.py 0.04 6.4 2 ../data/added_hhdata_"$i"_2.csv
  python main.py 0.04 13.5 5 ../data/added_hhdata_"$i"_2.csv
  python main.py 0.08 6.4 2 ../data/added_hhdata_"$i"_2.csv
  python main.py 0.08 13.5 5 ../data/added_hhdata_"$i"_2.csv
  python main.py 0.1 6.4 2 ../data/added_hhdata_"$i"_2.csv
  python main.py 0.1 13.5 5 ../data/added_hhdata_"$i"_2.csv
done
