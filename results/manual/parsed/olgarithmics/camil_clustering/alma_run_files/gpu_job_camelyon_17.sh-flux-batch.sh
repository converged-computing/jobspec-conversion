#!/bin/bash
#FLUX: --job-name=test_gpu
#FLUX: -c=6
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

module use /opt/software/easybuild/modules/all/
module load Mamba
source ~/.bashrc
conda activate exp_env
cd /home/ofourkioti/Projects/camil_clustering/
for i in {0..3};
do
python run.py  --experiment_name cam_17_camil_sb --feature_path /data/scratch/DBI/DUDBI/DYNCESYS/OlgaF/tmi/cam-17/feats/h5_files/ --label_file label_files/camelyon_17.csv --csv_file camelyon_17_splits/splits_${i}.csv   --k_sample 8 --single_branch;
done
