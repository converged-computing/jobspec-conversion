#!/bin/bash
#SBATCH --job-name=webds_writer
#SBATCH --output=/shares/rra_sarkar-2135-1003-00/faces/face_verification/slurm_outs/output.%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=20gb
#SBATCH --time=3-00:00:00
#SBATCH --qos=rradl

module load apps/anaconda
source /apps/anaconda3/5.3.1/etc/profile.d/conda.sh
conda activate torch_faces
srun python ./trainer/filter_tars.py --config briar_8
