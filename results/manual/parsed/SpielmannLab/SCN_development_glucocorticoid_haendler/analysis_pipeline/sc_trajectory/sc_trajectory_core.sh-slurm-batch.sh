#!/bin/bash
#SBATCH --job-name=sc_trajectory
#SBATCH --output=slurm-%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=200GB
#SBATCH --partition=shortterm

PATH=$WORK/.omics/anaconda3/bin:$PATH #add the anaconda installation path to the bash path
source $WORK/.omics/anaconda3/etc/profile.d/conda.sh # some reason conda commands are not added by default
conda activate scTrajectory
module load nextflow/v22.04.1
cp *.nf $SCRATCH/
cp *.yaml $SCRATCH/
cp -r bin $SCRATCH/
cd $SCRATCH
chmod +x bin/*
nextflow run sc_trajectory.nf -params-file sc_trajectory_params_neurons.yaml --id ${SCRATCH/"/scratch/"/} -resume
nextflow run sc_trajectory.nf -params-file sc_trajectory_params_astrocytes_by_annotation.yaml --id ${SCRATCH/"/scratch/"/} -resume
