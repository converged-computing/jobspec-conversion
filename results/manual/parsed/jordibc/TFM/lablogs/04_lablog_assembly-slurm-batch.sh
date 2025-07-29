#!/bin/bash
#SBATCH --job-name=metaspades
#SBATCH --output=logs/metaspades-%a.%A.out
#SBATCH --error=logs/metaspades-%a.%A.err
#SBATCH --mail-user=luciamartinfernandez99@gmail.com
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=15
#SBATCH --mem=150GB
#SBATCH --time=4-03:00:00
#SBATCH --array=0-116

ml SPAdes/3.15.2-GCC-8.2.0-2.31.1
module load MEGAHIT/1.2.8-GCCcore-8.2.0 
RUN_PATH_I=/home/lmartin/SRV_RyC/02-trimmomatic
RUN_PATH_O=/home/lmartin/SRV_RyC/05-assembly
names=($(cat /home/lmartin/SRV_RyC/00-raw_reads/samples_id.txt))
/beegfs/easybuild/CentOS/7.6.1810/Skylake/software/SPAdes/3.15.2-GCC-8.2.0-2.31.1/bin/metaspades.py -1 $RUN_PATH_I/${names[${SLURM_ARRAY_TASK_ID}]}_R1.clean_qc_pair.fastq -2 $RUN_PATH_I/${names[${SLURM_ARRAY_TASK_ID}]}_R2.clean_qc_pair.fastq -k auto -t 8 -m 1000 -o $RUN_PATH_O/${names[${SLURM_ARRAY_TASK_ID}]}/
