#!/bin/bash
#SBATCH --job-name=sbatch-nba-dl
#SBATCH --output=/scratch/dnp9357/rbda/nba_downloader/logs/demo_%j.out
#SBATCH --error=/scratch/dnp9357/rbda/nba_downloader/logs/demo_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=10GB
#SBATCH --time=01:00:00
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1

module purge
module load python/intel/3.8.6
singularity exec --overlay /scratch/dnp9357/rbda/overlay-15GB-500K.ext3:rw /scratch/work/public/singularity/cuda11.6.124-cudnn8.4.0.27-devel-ubuntu20.04.4.sif /bin/bash -c "
source /ext3/env.sh
python3 download_script.py
"
