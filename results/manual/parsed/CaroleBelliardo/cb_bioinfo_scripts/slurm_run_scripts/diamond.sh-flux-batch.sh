#!/bin/bash
#FLUX: --job-name=loopy-lamp-9399
#FLUX: -c=30
#FLUX: --urgency=16

module load singularity/3.5.3
SING_IMG='/database/hub/SINGULARITY_GALAXY/diamond:2.1.7--h5b5514e_0'
SING2='singularity exec --bind /kwak/hub/25_cbelliardo/MetaNema_LRmg/10Metag'
db_fasta=$1ls
db=$(echo $db_fasta |cut-d '.' -f1)'.dmnd'
$SING2 $SING_IMG diamond makedb -p $SLURM_JOB_CPUS_PER_NODE --in $db_fasta --db $db 
echo 'make db ok'
