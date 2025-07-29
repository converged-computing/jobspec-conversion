#!/bin/bash
#SBATCH --job-name=nfct-discovery
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err
#SBATCH --mail-user=miguel.ramon@upf.edu
#SBATCH --mail-type=START,END,FAIL
#SBATCH --nodes=6
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=8G
#SBATCH --time=08:00:00
#SBATCH --constraint=ntasks-per-node=1

module load Nextflow
TRAIT_DIR="/gpfs42/robbyfs/scratch/lab_anavarro/mramon/nf_caastools/Data/Traitfiles/"
for TRAIT_FILE in "$TRAIT_DIR"*.tab
do
        # Run caastools in Nextflow using the current trait file
        srun -n1 --exclusive nextflow run main.nf -with-singularity -with-tower -profile singularity --ct_tool discovery --traitfile "$TRAIT_FILE" &
done
wait
