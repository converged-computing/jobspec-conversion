#!/bin/bash
#SBATCH --job-name=cnnf
#SBATCH --output=/storage/vast-gfz-hpc-01/home/bryant/LS/10_IO/2307_super/outs/train/20231208/b/slurm.log
#SBATCH --error=/storage/vast-gfz-hpc-01/home/bryant/LS/10_IO/2307_super/outs/train/20231208/b/slurm_error.log
#SBATCH --mail-user=seth.bryant@gfz-potsdam.de
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=30G
#SBATCH --time=02:10:00

base_dir=/storage/vast-gfz-hpc-01/home/bryant/LS/10_IO/2307_super/outs/train_data/20231208
out_dir=/storage/vast-gfz-hpc-01/home/bryant/LS/10_IO/2307_super/outs/train/20231208/b
source /storage/vast-gfz-hpc-01/home/bryant/LS/09_REPOS/04_TOOLS/SRCNN-flood/env/conda_activate.sh
echo executing
cd ..
python -O cnnf/train.py --input-data-fp "${base_dir}/train_04_p160_input_20231208.h5" --eval-data-fp "/storage/vast-gfz-hpc-01/home/bryant/LS/10_IO/2307_super/tests/train_target_1_20231208.h5" --out-dir ${out_dir} --batch-size 20 --num-epochs 100 --num-workers 6  --seed 123
echo finished
