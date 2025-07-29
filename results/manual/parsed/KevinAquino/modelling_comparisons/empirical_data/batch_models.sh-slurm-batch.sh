#!/bin/bash
#SBATCH --job-name=BOLD
#SBATCH --account=kg98
#SBATCH --mail-user=kevin.aquino@monash.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=24000
#SBATCH --time=04:00:00

module load matlab/r2016a
echo $cm
matlab -nodisplay -r "run_multiple_BTF('${cm}'); exit"
