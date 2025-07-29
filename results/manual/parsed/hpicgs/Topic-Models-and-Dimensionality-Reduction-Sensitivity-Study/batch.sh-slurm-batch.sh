#!/bin/bash
#SBATCH --job-name=dr_benchmark_small
#SBATCH --account=doellner
#SBATCH --output=./status_experiment_distances/log_perplexity-%j_%a.txt
#SBATCH --error=./status_experiment_distances/err_training-%j_%a.txt
#SBATCH --mail-user=Tim.Cech@hpi.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=1-09:20:00
#SBATCH --constraint=ARCH:X86
#SBATCH --array=1-9999
#SBATCH --exclude=cx23,cx27,cx28

line=$(sed -n ${SLURM_ARRAY_TASK_ID}p < ./slurm_test/parameters.csv)
rec_column1=$(cut -d',' -f1 <<< "$line")
rec_column2=$(cut -d',' -f2 <<< "$line")
if [ ! -f "$rec_column1" ]; then
  echo python3 $rec_column2
  srun --container-image=./python-ml-15-02.sqsh --container-name=python-ml_batch27 --container-mounts=/hpi/fs00/share/fg-doellner/tim.cech/slurm_test:/home/tim.cech/slurm_test --container-workdir=/home/tim.cech/slurm_test python3 $rec_column2
fi
