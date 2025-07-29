#!/bin/bash
#SBATCH --job-name=fastbf_1D
#SBATCH --output=out/out_fastbf_1D.out
#SBATCH --error=err/err_fastbf_1D.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1500000
#SBATCH --time=16:00:00
#SBATCH --qos=bigmem

module load matlab
cd ../../test/fio
matlab -nojvm -r "batch_fastbf_1D;quit"
