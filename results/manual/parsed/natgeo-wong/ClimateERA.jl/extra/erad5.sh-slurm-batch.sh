#!/bin/bash
#SBATCH --job-name=CliERA5_dwn
#SBATCH --output=cliERA_dwn.%j.out
#SBATCH --error=cliERA_dwn.%j.err
#SBATCH --mail-user=useremail@serverhost.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=500
#SBATCH --time=1-00:00:00
#SBATCH --partition=huce_intel

module load Anaconda3/5.0.1-fasrc02
source activate base_env
python $1
