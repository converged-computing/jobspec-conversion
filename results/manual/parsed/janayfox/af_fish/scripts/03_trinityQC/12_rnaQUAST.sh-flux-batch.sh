#!/bin/bash
#FLUX: --job-name=adorable-hippo-6365
#FLUX: -c=2
#FLUX: -t=10
#FLUX: --priority=16

module purge 
module load StdEnv/2020
module load gcc/9.3.0
module load python/3.8.10 
module load quast/5.0.2
python /cvmfs/soft.computecanada.ca/easybuild/software/2020/avx512/Compiler/gcc9/quast/5.0.2/bin/quast.py -o quast.output -t 8 -l "Trinity_trim.fa" -e --rna-finding BN_bf.Trinity.fasta
python /cvmfs/soft.computecanada.ca/easybuild/software/2020/avx512/Compiler/gcc9/quast/5.0.2/bin/quast.py -o quast.output -t 8 -l "Trinity_trim.fa" -e --rna-finding BA_bf.Trinity.fasta
