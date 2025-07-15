#!/bin/bash
#FLUX: --job-name=nfct-discovery
#FLUX: -N=6
#FLUX: -c=20
#FLUX: -t=28800
#FLUX: --priority=16

module load Nextflow
TRAIT_DIR="/gpfs42/robbyfs/scratch/lab_anavarro/mramon/nf_caastools/Data/Traitfiles/"
for TRAIT_FILE in "$TRAIT_DIR"*.tab
do
        # Run caastools in Nextflow using the current trait file
        srun -n1 --exclusive nextflow run main.nf -with-singularity -with-tower -profile singularity --ct_tool discovery --traitfile "$TRAIT_FILE" &
done
wait
