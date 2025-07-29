#!/bin/bash
#SBATCH --mail-user=samgould@mit.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --qos=low
#SBATCH --array=1-44
#SBATCH --exclude=c[5-22]

module load miniconda3/v4
source /home/software/conda/miniconda3/bin/condainit
conda activate /home/samgould/.conda/envs/crispresso_env
cd /net/bmc-lab2/data/lab/sanchezrivera/samgould
config=/net/bmc-lab2/data/lab/sanchezrivera/samgould/sensor_extraction_config.txt
R1_FILE=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)
R2_FILE=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $3}' $config)
folder_name=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $4}' $config)
python3 crispresso_analysis.py p53_crispresso_quant.csv ${folder_name}
