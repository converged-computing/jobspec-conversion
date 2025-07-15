#!/bin/bash
#FLUX: --job-name=SIM.coll
#FLUX: -t=7200
#FLUX: --priority=16

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
