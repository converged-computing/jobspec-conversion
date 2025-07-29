#!/bin/bash
#SBATCH --job-name=literatureTestSuiteAnalysis
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5G
#SBATCH --time=1-00:00:00
#SBATCH --array=1-906

module load gcccore/10.2.0
module load cmake/3.18.4
module load eigen/3.3.8
cd ../cpp_code
./main litSuiteTesting ${SLURM_ARRAY_TASK_ID}
