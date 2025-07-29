#!/bin/bash
#SBATCH --job-name=parrot
#SBATCH --output=slurm_out/parrot-%j.out
#SBATCH --mail-user=js11531@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=32GB
#SBATCH --time=06:00:00
#SBATCH --constraint=ntasks-per-node=1

echo "hostname:" `hostname`
echo "file: " $FILE
singularity exec --nv --overlay ~/labshare/Parrot_Paraphraser/overlay-50G-10M.ext3:ro /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif  /bin/bash -c "
source /ext3/env.sh
conda activate parrot
python parrot/paraphrase.py $FILE
"
