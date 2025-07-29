#!/bin/bash
#SBATCH --job-name=quantum
#SBATCH --output=./hpc_output/%x_%j.out
#SBATCH --error=./hpc_output/%x_%j.err
#SBATCH --mail-user=rtealwitter@nyu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=192G
#SBATCH --time=12:00:00

singularity exec --overlay $SCRATCH/overlay-25GB-500K.ext3:rw /scratch/work/public/singularity/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif /bin/bash -c "
source /ext3/env.sh
conda activate quantum
python planes.py
"
