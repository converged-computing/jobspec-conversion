#!/bin/bash
#SBATCH --job-name=irs-dengue
#SBATCH --account=epi
#SBATCH --output=./auto_output/cont_%A_%a.out
#SBATCH --error=./auto_output/cont_%A_%a.err
#SBATCH --mail-user=tjhladish@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2000
#SBATCH --time=1-00:00:00
#SBATCH --qos=epi-b
#SBATCH --chdir=/home/tjhladish/work/dengue/exp/abc-irs_refit2
#SBATCH --array=0-999

module load gcc/7.3.0 gsl
for i in `seq 1 1`;
do
    ./abc_sql run_posterior.json --simulate
done
