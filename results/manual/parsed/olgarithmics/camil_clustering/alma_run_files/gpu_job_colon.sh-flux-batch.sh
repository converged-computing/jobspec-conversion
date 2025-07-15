#!/bin/bash
#FLUX: --job-name=test_gpu
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --priority=16

module use /opt/software/easybuild/modules/all/
module load Mamba
source ~/.bashrc
conda activate exp_env
cd /home/ofourkioti/Projects/camil_clustering/
for i in {0..4};
do python run.py --experiment_name colon_sb --feature_path /data/scratch/DBI/DUDBI/DYNCESYS/OlgaF/tmi/colon_feats/h5_files/ --label_file label_files/colon_data.csv --csv_file colon_csv_splits/splits_${i}.csv  --epoch 100  --k_sample 5 --single_branch;
done
