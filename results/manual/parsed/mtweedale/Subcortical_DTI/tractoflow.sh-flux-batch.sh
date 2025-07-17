#!/bin/bash
#FLUX: --job-name=dirty-fudge-9538
#FLUX: -c=40
#FLUX: -t=604800
#FLUX: --urgency=16

export NXF_CLUSTER_SEED='$(shuf -i 0-16777216 -n 1)'

module load StdEnv/2020 intel/2020.1.217 mrtrix/3.0.1 nextflow apptainer
export NXF_CLUSTER_SEED=$(shuf -i 0-16777216 -n 1)
nextflow run /home/mtweed/scratch/tractoflow/main.nf --input /home/mtweed/scratch/tractoflow_hcp_dwi/hcp/ -profile skip_preprocessing --dti_shells "0 1000 2000 3000" --fodf_shells "0 1000 2000 3000" --sh_order "8" -with-singularity /home/mtweed/scratch/tractoflow/scilus_1.5.0.sif -with-mpi -resume
