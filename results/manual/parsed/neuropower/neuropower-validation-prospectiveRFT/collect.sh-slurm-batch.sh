#!/bin/bash
#SBATCH --job-name=SIM.coll
#SBATCH --output=error/out.SIM.coll
#SBATCH --error=error/err.SIM.coll
#SBATCH --mail-user=joke.durnez@gmail.com
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --qos=russpold

export PILOT='15'
export FINAL='61'
export EXC='2.3'
export ADAPTIVE='predictive'
export SIMS='30'
export MODALITY='SIM'
export MODEL='RFT'
export OUTDIR='$(echo $RESDIR$MODALITY\_$ADAPTIVE\_$PILOT\_$EXC\_$MODEL)'

. ./config_tacc.sh
module use /scratch/PI/russpold/modules
source /share/PI/russpold/software/setup_all.sh
module load R/3.2.0
export PILOT=15
export FINAL=61
export EXC="2.3"
export ADAPTIVE="predictive"
export SIMS=30
export MODALITY='SIM'
export ADAPTIVE='predictive'
export MODEL='RFT'
export OUTDIR=$(echo $RESDIR$MODALITY\_$ADAPTIVE\_$PILOT\_$EXC\_$MODEL)
python -i $SCRIPTDIR/aggregate_estimation.py $PILOT $FINAL $SIMS $MODALITY $ADAPTIVE $EXC $MODEL
Rscript $HOMEDIR\Figures/HCP_figures_NIMG.R $TABDIR $HOMEDIR $FIGDIR
