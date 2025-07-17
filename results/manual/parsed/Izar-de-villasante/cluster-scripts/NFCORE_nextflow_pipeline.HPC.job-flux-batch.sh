#!/bin/bash
#FLUX: --job-name=job_CLIP_nextflow
#FLUX: -c=2
#FLUX: -t=7200
#FLUX: --urgency=16

export NXF_EXECUTOR='slurm          # set SLURM as the default executor (=spawns sbatch jobs)'
export NXF_OPTS='-Xms500M -Xmx2G"  # restrict Java VM memory usage'

echo "start: "; pwd; hostname; date
export NXF_EXECUTOR=slurm          # set SLURM as the default executor (=spawns sbatch jobs)
export NXF_OPTS="-Xms500M -Xmx2G"  # restrict Java VM memory usage
module load Java
module load singularity-3.8.3-gcc-11.2.0-rlxj6fi
module load nextflow-21.04.3-gcc-11.2.0-mhxn2lh
nextflow run nf-core/clipseq --input test.sample_design.file --genome GRCh38 -profile singularity --peakcaller pureclip
echo "end: "; pwd; hostname; date
