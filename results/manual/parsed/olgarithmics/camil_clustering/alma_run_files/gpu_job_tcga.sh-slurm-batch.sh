#!/bin/bash
#SBATCH --job-name=test_gpu
#SBATCH --output=/home/ofourkioti/Projects/camil_clustering/results/tcga_camil_sb.txt
#SBATCH --error=/home/ofourkioti/Projects/camil_clustering/results/tcga_exp.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --time=3-00:00:00

module use /opt/software/easybuild/modules/all/
module load Mamba
source ~/.bashrc
conda activate exp_env
cd /home/ofourkioti/Projects/camil_clustering/
for i in {0..3};
do
python run.py  --experiment_name tcga_camil_sb --k 8 --feature_path /data/scratch/DBI/DUDBI/DYNCESYS/OlgaF/tmi/tcga_lung/feats/h5_files/ --label_file label_files/tcga_data.csv --csv_file tcga_lung_files/splits_${i}.csv  --k_sample 8 --single_branch;
done
