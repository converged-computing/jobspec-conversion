#!/bin/bash
#SBATCH --job-name=psipred-array
#SBATCH --output=psibatchout.%J
#SBATCH --error=psibatcherr.$J
#SBATCH --mail-user=arronslacey@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=00:06:00
#SBATCH --array=1001

module load compiler/gnu/4.8.0
module load R/3.2.3
code=${HOME}/Phd/script_dev/rfpipeline.sh
data_file="epsnps_${SLURM_ARRAY_TASK_ID}.fasta"
echo ${data_file}
${code} ${data_file}
