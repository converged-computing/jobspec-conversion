#!/bin/bash
#SBATCH --job-name=sc_velo
#SBATCH --output=slurm-%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=250GB
#SBATCH --partition=shortterm

PATH=$WORK/.omics/anaconda3/bin:$PATH #add the anaconda installation path to the bash path
source $WORK/.omics/anaconda3/etc/profile.d/conda.sh # some reason conda commands are not added by default
conda activate scVelocity
module load nextflow/v22.04.1
cp * $SCRATCH/
cp -r ../src $SCRATCH/
cd $SCRATCH
nextflow run sc_velo.nf -params-file sc_velo_params.yaml --id ${SCRATCH/"/scratch/"/}
