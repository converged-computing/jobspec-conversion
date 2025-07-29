#!/bin/bash
#SBATCH --job-name=tabula_muris paretoMTL_MINE
#SBATCH --account=punim0890
#SBATCH --mail-user=hui.li3@student.unimelb.edu.au
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5000
#SBATCH --time=4-10:00:00
#SBATCH --partition=physical
#SBATCH --array=0-19

if [ "x$SLURM_JOB_ID" == "x" ]; then
   echo "You need to submit your job to the queuing system with sbatch"
   exit 1
fi
module load anaconda3/2020.07
source activate sharedenv
module load web_proxy
python3 paretoMTL_MINE.py ${SLURM_ARRAY_TASK_ID}
