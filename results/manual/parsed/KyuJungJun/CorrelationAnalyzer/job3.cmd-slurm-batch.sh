#!/bin/bash
#SBATCH --job-name=08_run
#SBATCH --account=TG-DMR970008S
#SBATCH --output=out.%j
#SBATCH --error=error.%j
#SBATCH --mail-user=computation.management@gmail.com
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00

export OMP_NUM_THREADS='1'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export LD_PRELOAD='/home1/apps/tacc-patches/getcwd-patch.so:$LD_PRELOAD'

export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
export LD_PRELOAD=/home1/apps/tacc-patches/getcwd-patch.so:$LD_PRELOAD
conda activate base
python count.py
