#!/bin/bash
#SBATCH --job-name=decon2519-10Xscaled-allNCI
#SBATCH --output=decon2519-10Xscaled-allNCI.out
#SBATCH --error=decon2519-10Xscaled-allNCI.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10000
#SBATCH --time=05:00:00
#SBATCH --qos=normal

source activate snakemake
python3 -c "import deconvolve as sev; sev.main(1, '/oak/stanford/groups/quake/sevahn/alzheimers/ad_cpmOnly_postQC_unstranded_FINAL.csv', ['2519'] , 'NNLS', '2519',  jackknife = False)"
python3 -c "import deconvolve as sev; sev.main(1, '/oak/stanford/groups/quake/sevahn/alzheimers/ad_cpmOnly_postQC_unstranded_FINAL.csv', ['2519'] , 'QP', '2519',  jackknife = False)"
python3 -c "import deconvolve as sev; sev.main(1,  '/oak/stanford/groups/quake/sevahn/alzheimers/ad_cpmOnly_postQC_unstranded_FINAL.csv', ['2519'] , 'nuSVR', '2519',  jackknife = False)"
