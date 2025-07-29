#!/bin/bash
#SBATCH --job-name=kid_decoupleR
#SBATCH --output=%x_%A_%a.out
#SBATCH --error=%x_%A_%a.err
#SBATCH --mail-user=jbarham3@uab.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=255000
#SBATCH --time=2-02:00:00
#SBATCH --array=0-34

export SINGULARITYENV_PASSWORD='pass'
export SINGULARITYENV_USER='jbarham3' #change this to your user'

module load R
module load Singularity/3.5.2-GCC-5.4.0-2.26
wd=/data/user/jbarham3/230227_JW_Setbp1Manuscript #change this to match your project directory path
export SINGULARITYENV_PASSWORD='pass'
export SINGULARITYENV_USER='jbarham3' #change this to your user
cd ${wd}
RDATA_FILE=${wd}/data/processed/decoupleR_expression_inputs/kidney_expression.Rdata
echo "Opening ${RDATA_FILE}"
PRIOR_NET=${wd}/data/processed/decoupleR_prior_CollecTRI/mouse_prior_tri.csv
echo "Prior Network from ${PRIOR_NET}"
ITEM=$(Rscript -e "load('${RDATA_FILE}'); cat(names(decoupleR_expression)[${SLURM_ARRAY_TASK_ID}])")
echo "Processing: ${ITEM}"
TISSUE="kidney"
MIN_N=5
singularity exec --cleanenv --no-home -B ${wd} ${wd}/bin/docker/setbp1_manuscript_1.0.6.sif Rscript --vanilla ${wd}/src/network_scripts/decoupleR/02_decoupleR_analysis.R ${RDATA_FILE} ${PRIOR_NET} ${ITEM} ${TISSUE} ${MIN_N}
