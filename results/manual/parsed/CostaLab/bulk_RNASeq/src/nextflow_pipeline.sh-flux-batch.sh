#!/bin/bash
#FLUX: --job-name=nextflow_rnaseq_trial
#FLUX: -n=12
#FLUX: -t=324000
#FLUX: --urgency=16

export PATH='/home/izkf/nextflow/miniconda2/bin:/home/izkf/nextflow/miniconda2/envs/nf-core-rnaseq-1.4.2/bin:$PATH'
export PYTHONPATH='/home/izkf/nextflow/miniconda2/envs/nf-core-rnaseq-1.4.2/lib/python2.7/site-packages:$PYTHONPATH'
export LD_LIBRARY_PATH='/home/izkf/nextflow/miniconda2/envs/nf-core-rnaseq-1.4.2/lib:$LD_LIBRARY_PATH'

export PATH=/home/izkf/nextflow/miniconda2/bin:/home/izkf/nextflow/miniconda2/envs/nf-core-rnaseq-1.4.2/bin:$PATH
export PYTHONPATH=/home/izkf/nextflow/miniconda2/envs/nf-core-rnaseq-1.4.2/lib/python2.7/site-packages:$PYTHONPATH
export LD_LIBRARY_PATH=/home/izkf/nextflow/miniconda2/envs/nf-core-rnaseq-1.4.2/lib:$LD_LIBRARY_PATH
cd <set directory here>
$reads = #<set your reads directory path>
$ref_index = #<set your reference index file\' path>
$ref_fa = #<set your reference fasta file\' path>
$ref_gtf = #<set your reference annotation file\' path>
$nf_out = #<set your output directory path>
$name = 'rnaseq1_out'
$cpu = 12
$mem = '4.0GB'
nextflow run /home/izkf/nextflow/nf-core/rnaseq --reads $reads  --fc_group_features gene_id  --fc_extra_attributes gene_name  --fc_count_type transcript --pseudo_aligner salmon --star_index $ref_index  --fasta $ref_fa  --gtf $ref_gtf --saveReference --saveUnaligned --gencode --removeRiboRNA --outdir $nf_out  --name $name --max_cpus $cpu  --max_memory $mem  --resume
