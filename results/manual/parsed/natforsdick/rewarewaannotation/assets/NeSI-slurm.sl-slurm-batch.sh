#!/bin/bash
#SBATCH --job-name=[NAME]
#SBATCH --account=[ACCOUNTID]
#SBATCH --output=slurm-%x-%A-%a.log
#SBATCH --mail-user=[EMAIL]
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --time=5-00:00:00
#SBATCH --constraint=ntasks-per-node=1

cd /path/to/nobackup/annotation/
module load Java/11.0.4 Singularity/3.11.3
nextflow -version
setfacl -b "${NXF_SINGULARITY_CACHEDIR}" ./rewarewaannotation/main.nf
setfacl -b "${SINGULARITY_TMPDIR}" ./rewarewaannotation/main.nf
nextflow run /path/to/nobackup/annotation/rewarewaannotation/ \
   -params-file /path/to/nobackup/annotation/rata_params.yml \
   -profile NeSI
