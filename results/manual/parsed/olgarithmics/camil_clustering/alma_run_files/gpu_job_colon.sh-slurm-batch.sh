#!/bin/bash
#SBATCH --job-name=test_gpu
#SBATCH --output=/home/ofourkioti/Projects/camil_clustering/results/colon_sb.txt
#SBATCH --error=/home/ofourkioti/Projects/camil_clustering/results/error.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu

module use /opt/software/easybuild/modules/all/
module load Mamba
source ~/.bashrc
conda activate exp_env
cd /home/ofourkioti/Projects/camil_clustering/
for i in {0..4};
do python run.py --experiment_name colon_sb --feature_path /data/scratch/DBI/DUDBI/DYNCESYS/OlgaF/tmi/colon_feats/h5_files/ --label_file label_files/colon_data.csv --csv_file colon_csv_splits/splits_${i}.csv  --epoch 100  --k_sample 5 --single_branch;
done
