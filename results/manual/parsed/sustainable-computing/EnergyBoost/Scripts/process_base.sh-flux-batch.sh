#!/bin/bash
#FLUX: --job-name=solarRL
#FLUX: -c=6
#FLUX: -t=840
#FLUX: --urgency=16

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
