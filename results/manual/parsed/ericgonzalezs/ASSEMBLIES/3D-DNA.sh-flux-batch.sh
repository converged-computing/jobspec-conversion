#!/bin/bash
#FLUX: --job-name=crusty-general-8558
#FLUX: -c=15
#FLUX: -t=604800
#FLUX: --urgency=16

export PATH='/somedirwhereis3ddna/3d-dna:$PATH'

mkdir somedirtorun3ddna
git clone https://github.com/aidenlab/3d-dna.git
cd 3d-dna
module load StdEnv/2020 python/3.11.2
virtualenv 3ddna
source 3ddna/bin/activate
  pip install scipy numpy matplotlib #libraries required for 3d-dna 
deactivate
ln -s /pathtoyourfasta/yourfasta.fasta
ln -s /pathtoyourmergednodups/merged_nodups.txt
module load StdEnv/2020 python/3.10.2 java/17.0.2 lastz/1.04.03
export PATH="/somedirwhereis3ddna/3d-dna:$PATH"
source /home/egonza02/scratch/SOFTWARE/3D_DNA/3d-dna/3DDNA/bin/activate
run-asm-pipeline.sh -r 0 Harg2202r1.0-20210824.genome.new_names.fasta merged_nodups.txt
deactivate
