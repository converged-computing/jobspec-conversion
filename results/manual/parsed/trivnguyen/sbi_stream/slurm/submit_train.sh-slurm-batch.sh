#!/bin/bash
#SBATCH --job-name=train_0
#SBATCH --output=out-train.out
#SBATCH --error=err-train.err
#SBATCH --mail-user=tnguy@mit.edu
#SBATCH --mail-type=all
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=05:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=v100

module unload python
if [ -f "/mnt/home/tnguyen/miniconda3/etc/profile.d/conda.sh" ]; then
    . "/mnt/home/tnguyen/miniconda3/etc/profile.d/conda.sh"
else
    export PATH="/mnt/home/tnguyen/miniconda3/bin:$PATH"
fi
conda activate geometric
config=$(realpath config.py)
cd /mnt/home/tnguyen/projects/sbi_stream
python train.py --config $config
exit 0
