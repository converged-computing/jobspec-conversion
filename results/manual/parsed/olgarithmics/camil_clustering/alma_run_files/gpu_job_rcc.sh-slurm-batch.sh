#!/bin/bash
#SBATCH --job-name=test_gpu
#SBATCH --output=/home/ofourkioti/Projects/SAD_MIL/camelyon_results/camil_rcc_dense.txt
#SBATCH --error=/home/ofourkioti/Projects/SAD_MIL/camelyon_results/error.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --time=3-00:00:00

module use /opt/software/easybuild/modules/all/
module load Mamba
source ~/.bashrc
conda activate exp_env
cd /home/ofourkioti/Projects/SAD_MIL/
for i in {0..3};
do
python run.py  --experiment_name camil_rcc --feature_path /data/scratch/DBI/DUDBI/DYNCESYS/OlgaF/tmi/rcc/feats/h5_files/ --label_file label_files/rcc_data.csv --adj_shape 8 --csv_file rcc_file_splits/splits_${i}.csv  --lambda1 1 --epoch 200 --eta 1 --topk 60 --subtyping --n_classes 3;
done
