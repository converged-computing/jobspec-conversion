#!/bin/bash
#FLUX: --job-name=KA_repeatmasker
#FLUX: -c=48
#FLUX: --queue=bigmem
#FLUX: -t=518400
#FLUX: --urgency=16

threads=48
module load singularity/3.5.2
singdir=/nfs/scratch/papayv/Tarakihi/TARdn/09_Repeat/new_pipeline/V2P/
sing=$singdir/repeatmasker_4.1.1--pl526_1.sif
dir=/nfs/scratch/papayv/Tarakihi/TARdn/Z_fish_assemblies/9_repeat_masking/KA/
assembly_dir=/nfs/scratch/papayv/Tarakihi/TARdn/Z_fish_assemblies/Genome_assemblies/KA
assembly=KAdn_assembly_V1_srn.fasta
repeat_library=/nfs/scratch/papayv/Tarakihi/TARdn/Z_fish_assemblies/9_repeat_masking/KA/KAdn_V1_repeat_lib_TARV2Pdb_and_denovo.fa
time echo "use RepeatMasker to get a masked sequence and a table of repeats famillies"
singularity exec $sing RepeatMasker -gff -xsmall -pa $threads -lib $repeat_library $assembly_dir/$assembly
echo "job finished"
