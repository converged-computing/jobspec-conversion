#!/bin/bash
#FLUX: --job-name=StG23_AMG_Hunter_Prok
#FLUX: -c=64
#FLUX: -t=255600
#FLUX: --urgency=16

module load cesga/system miniconda3/22.11.1-1
conda activate /mnt/netapp1/Store_CSIC/home/csic/eyg/fhc/Conda_Envs/basic
cd /mnt/netapp1/Store_CSIC/home/csic/eyg/fhc/Databases/OceanDNA/
python3 /mnt/netapp1/Store_CSIC/home/csic/eyg/fhc/repos/ICM_Code/Get_Seqs.py --input_seq All_OCeanDNA_MAGs_PEGs.faa --protein True --matched_output_sequences OceanDNA_Species_Rep_MAGs_PEGs.faa --list List_OceanDNA_MAG_IDs_Species_Rep_only.txt
rm -f /mnt/netapp1/Store_CSIC/home/csic/eyg/fhc/Databases/OceanDNA/Unmatched_Sequences.fasta
cd /mnt/lustre/scratch/nlsas/home/csic/eyg/fhc/StG23/Prokaryotes/Annotation/
python3 /mnt/netapp1/Store_CSIC/home/csic/eyg/fhc/repos/ICM_Code/AMG_Hunter.py --kegg_db  /mnt/netapp1/Store_CSIC/home/csic/eyg/fhc/Databases/KOfam/All_KOfam.hmm --kegg_json /mnt/netapp1/Store_CSIC/home/csic/eyg/fhc/Databases/KOfam/ko00001.json --annotate True --threads 63 --cds /mnt/netapp1/Store_CSIC/home/csic/eyg/fhc/Databases/OceanDNA/OceanDNA_Species_Rep_MAGs_PEGs.faa --pfam_db /mnt/netapp2/Store_uni/COMPARTIDO/pfamdb/DB/Pfam-A.hmm --skip_uniref True
