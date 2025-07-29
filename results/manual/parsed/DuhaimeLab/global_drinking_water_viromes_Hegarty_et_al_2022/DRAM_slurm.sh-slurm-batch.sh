#!/bin/bash
#SBATCH --job-name=dram
#SBATCH --account=kwigg1
#SBATCH --mail-user=hegartyb@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=10gb
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-2

echo $SLURM_JOB_NODELIST
echo ${SLURM_ARRAY_TASK_ID}
echo start
bash /scratch/kwigg_root/kwigg/hegartyb/SnakemakeAssemblies3000/CompetitiveMapping/Scripts/DRAM.sh ${SLURM_ARRAY_TASK_ID}
echo done
