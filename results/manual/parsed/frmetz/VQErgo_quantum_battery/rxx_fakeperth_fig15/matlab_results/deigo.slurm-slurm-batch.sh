#!/bin/bash
#SBATCH --job-name=vqe_passive_energy
#SBATCH --mail-user=tuanduc.hoang@oist.jp
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5G
#SBATCH --time=1-00:00:00
#SBATCH --array=0-99

module load ruse
source /home/t/tuan-hoang/miniconda3/etc/profile.d/conda.sh
conda activate mlenv
ruse -s --label=${SLURM_ARRAY_TASK_ID} python rxx_vqe_noisy.py ${SLURM_ARRAY_TASK_ID}
