#!/bin/bash
#SBATCH --job-name=lunar_pnt
#SBATCH --output=lunar_pnt_%j.txt
#SBATCH --error=lunar_pnt_%j.txt
#SBATCH --mail-user=yalan@stanford.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=2G
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1

export SLURM_SUBMIT_DIR='/home/groups/gracegao/prn_codes/doppler_prn'

module load python/3.9
export SLURM_SUBMIT_DIR=/home/groups/gracegao/prn_codes/doppler_prn
cd $SLURM_SUBMIT_DIR
lscpu
mkdir results
python3 run.py --s 0 --f 9.5e3 --t 1.941747572815534e-7 --m 8 --n 5113 --doppreg $SLURM_ARRAY_TASK_ID --maxit 1_000_000_000 --name "results/lunar_pnt" --log 1_000 --obj --obj_v_freq
