#!/bin/bash
#SBATCH --job-name=mouseHGs
#SBATCH --account=indikar0
#SBATCH --output=/nfs/turbo/umms-indikar/Joshua/Main/Projects/AFOSR/mouseCodes/%x-%j.log
#SBATCH --mail-user=jpic@umich.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50GB
#SBATCH --time=4-00:00:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-3

module load matlab
matlab -nodisplay -r "mouseCodes/scratch2($SLURM_ARRAY_TASK_ID)"
