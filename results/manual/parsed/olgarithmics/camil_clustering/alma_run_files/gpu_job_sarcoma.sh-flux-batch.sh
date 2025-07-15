#!/bin/bash
#FLUX: --job-name=test_gpu
#FLUX: -c=10
#FLUX: --queue=gpuhm
#FLUX: -t=43200
#FLUX: --priority=16

module use /opt/software/easybuild/modules/all/
module load Mamba
source ~/.bashrc
conda activate exp_env
cd /home/ofourkioti/Projects/camil_clustering/
for i in {0..4};
do python run.py  --experiment_name lipo_5 --feature_path /data/scratch/DBI/DUDBI/DYNCESYS/OlgaF/tmi/SAR/feats/h5_files --label_file label_files/multi_lipo.csv --csv_file lipo_csv_splits/splits_${i}.csv  --epoch 100 --save_dir SAR_Saved_model --lr 0.005;
done
