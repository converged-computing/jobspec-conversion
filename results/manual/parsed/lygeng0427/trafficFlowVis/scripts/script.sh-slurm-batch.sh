#!/bin/bash
#SBATCH --job-name=matching_objects
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu
#SBATCH --mem=60GB
#SBATCH --time=1-00:00:00
#SBATCH --partition=a100_1,a100_2,v100,rtx8000

ext3_path=/scratch/lg3490/tfv/overlay-25GB-500K.ext3
sif_path=/scratch/work/public/singularity/cuda12.1.1-cudnn8.9.0-devel-ubuntu22.04.2.sif
singularity exec --nv \
--overlay ${ext3_path}:ro \
${sif_path} /bin/bash -c "
source /ext3/env.sh
conda activate vis
python main.py
"
