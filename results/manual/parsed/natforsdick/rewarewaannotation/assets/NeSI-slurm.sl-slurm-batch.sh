#!/bin/bash
#FLUX: --job-name=[NAME]
#FLUX: -c=2
#FLUX: -t=432000
#FLUX: --urgency=16

cd /path/to/nobackup/annotation/
module load Java/11.0.4 Singularity/3.11.3
nextflow -version
setfacl -b "${NXF_SINGULARITY_CACHEDIR}" ./rewarewaannotation/main.nf
setfacl -b "${SINGULARITY_TMPDIR}" ./rewarewaannotation/main.nf
nextflow run /path/to/nobackup/annotation/rewarewaannotation/ \
   -params-file /path/to/nobackup/annotation/rata_params.yml \
   -profile NeSI
