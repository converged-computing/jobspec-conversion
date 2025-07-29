#!/bin/bash
#SBATCH --account=m2_jgu-amd
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=14
#SBATCH --time=00:15:00
#SBATCH --partition=parallel
#SBATCH --constraint=skylake

module purge # ensures vanilla environment
module load lang/R # will load most current version of R
echo "------child bash arguments------"
echo $1
echo "------end of bash output------"
srun Rscript 302_signal_variability_analysis_single_trial.R \
  --sensor_n $1 --task_i "Odd/Even" --jobs 14
echo "------job is finished------"
