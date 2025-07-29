#!/bin/bash
#SBATCH --output=reports/pxp_%j.out
#SBATCH --error=reports/pxp_%j.err
#SBATCH --mail-user=nvelez@fas.harvard.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=00:02:00

module load ncf
module load matlab/R2021a-fasrc01
module load spm/12.7487-fasrc01
matlab -nodisplay -nosplash -r "script_6_pxp;exit"
