#!/bin/bash
#FLUX: --job-name=test_gpu
#FLUX: -c=8
#FLUX: --queue=gpuhm
#FLUX: -t=172800
#FLUX: --urgency=16

module use /opt/software/easybuild/modules/all/
module load Mamba
source ~/.bashrc
conda activate exp_env
cd /home/ofourkioti/Projects/SAD_MIL/
for i in {0..4};
do python run.py --experiment_name cam_17_top_20  --feature_path /data/scratch/DBI/DUDBI/DYNCESYS/OlgaF/tmi/cam-16/sad_mil/feats/h5_files/ --label_file label_files/camelyon_data.csv --csv_file camelyon_csv_files/splits_${i}.csv --lambda1 1 --epoch 200 --eta 1 --topk 20;
done
