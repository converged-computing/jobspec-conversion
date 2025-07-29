#!/bin/bash
#SBATCH --job-name=solarRL
#SBATCH --output=%N-%j.out
#SBATCH --error=%N-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=32000M
#SBATCH --time=00:14:00

module load cuda cudnn python/3.5.2
source tensorflow/bin/activate
for i in 2002
do
  #python test_ddpg.py 0.2 0 0 data_predicted2/predicted_hhdata_"$i"_2.csv
  python3 solar_a2c_linear.py 0.2 6.4 2 data_predicted2/predicted_hhdata_"$i"_2.csv
  python3 solar_a2c_linear.py 0.2 13.5 5 data_predicted2/predicted_hhdata_"$i"_2.csv
  #python test_ddpg.py 0.04 0 0 data_predicted2/predicted_hhdata_"$i"_2.csv
  python3 solar_a2c_linear.py 0.04 6.4 2 data_predicted2/predicted_hhdata_"$i"_2.csv
  python3 solar_a2c_linear.py 0.04 13.5 5 data_predicted2/predicted_hhdata_"$i"_2.csv
  #python test_ddpg.py 0.08 0 0 data_predicted2/predicted_hhdata_"$i"_2.csv
  python3 solar_a2c_linear.py 0.08 6.4 2 data_predicted2/predicted_hhdata_"$i"_2.csv
  python3 solar_a2c_linear.py 0.08 13.5 5 data_predicted2/predicted_hhdata_"$i"_2.csv
  #python test_ddpg.py 0.1 0 0 data_predicted2/predicted_hhdata_"$i"_2.csv
  python3 solar_a2c_linear.py 0.1 6.4 2 data_predicted2/predicted_hhdata_"$i"_2.csv
  python3 solar_a2c_linear.py 0.1 13.5 5 data_predicted2/predicted_hhdata_"$i"_2.csv
done
