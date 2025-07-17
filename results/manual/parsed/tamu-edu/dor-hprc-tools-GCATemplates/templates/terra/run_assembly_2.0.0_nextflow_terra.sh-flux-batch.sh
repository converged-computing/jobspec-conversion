#!/bin/bash
#FLUX: --job-name=nextflow
#FLUX: -c=28
#FLUX: -t=3600
#FLUX: --urgency=16

module load Nextflow/20.10.0
<<README
    - assembly manual: https://gitlab.com/cgps/ghru/pipelines/dsl2/pipelines/assembly
    - Nextflow manual: https://www.nextflow.io/docs/latest/index.html
README
input_dir='small_test_input'    
adapter_file='adapters.fas'
confindr_db_path='confindr_database'
workflow='main.nf'
fastq_pattern='*{R,_}*.fastq.gz'
echo "process.container = '/sw/hprc/biocontainers/assembly_2.0.0.sif'
singularity {
  enabled = true
  runOptions = '--bind /scratch --bind /work --no-home'
}
process.cpus = $SLURM_CPUS_PER_TASK
process.memory = $SLURM_MEM_PER_NODE
process.executor = 'local'" > nextflow.config
output_dir='assembly_output'
nextflow run $workflow --input_dir $input_dir --fastq_pattern "$fastq_pattern" --adapter_file $adapter_file -with-singularity --confindr_db_path $confindr_db_path --output_dir $output_dir
<<CITATION
    - Acknowledge TAMU HPRC: https://hprc.tamu.edu/research/citations.html
    - Nextflow:
            Di Tommaso, P., Chatzou, M., Floden, E. W., Barja, P. P., Palumbo, E., & Notredame, C. (2017).
            Nextflow enables reproducible computational workflows. Nature Biotechnology, 35(4), 316–319. 
CITATION
