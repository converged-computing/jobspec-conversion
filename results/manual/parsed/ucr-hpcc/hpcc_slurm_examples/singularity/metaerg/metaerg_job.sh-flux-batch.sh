#!/bin/bash
#FLUX: --job-name=Metaerg_Sing
#FLUX: -c=8
#FLUX: --queue=intel,batch
#FLUX: -t=87300
#FLUX: --urgency=16

module load metaerg # This auto loads singularity
singularity exec -B data:/data $METAERG_IMG setup_db.pl -o /data -v 132
singularity exec -B data:/data $METAERG_IMG metaerg.pl --dbdir /data/db --outdir /data/my_metaerg_output /data/contig.fasta
