#!/bin/bash
#FLUX: --job-name=test_gpu
#FLUX: -c=6
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --priority=16

module use /opt/software/easybuild/modules/all/
module load Mamba
source ~/.bashrc
conda activate exp_env
cd /home/ofourkioti/Projects/camil_clustering/
for i in {0..3};
do
python run.py  --experiment_name tcga_camil_sb --k 8 --feature_path /data/scratch/DBI/DUDBI/DYNCESYS/OlgaF/tmi/tcga_lung/feats/h5_files/ --label_file label_files/tcga_data.csv --csv_file tcga_lung_files/splits_${i}.csv  --k_sample 8 --single_branch;
done
