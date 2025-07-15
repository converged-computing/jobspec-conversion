#!/bin/bash
#FLUX: --job-name=BM_repeat_libraries
#FLUX: -c=18
#FLUX: --queue=parallel
#FLUX: -t=432000
#FLUX: --priority=16

dir=/nfs/scratch/papayv/Tarakihi/TARdn/Z_fish_assemblies/9_repeat_masking/BM/
singdir=/nfs/scratch/papayv/Tarakihi/TARdn/09_Repeat/new_pipeline/V2P/
sing=$singdir/tetools_latest.sif
genome1=BMdn_assembly_V1_srn
genome1_fasta=/nfs/scratch/papayv/Tarakihi/TARdn/Z_fish_assemblies/Genome_assemblies/BM/BMdn_assembly_V1_srn.fasta
threads=18
db_lib=/nfs/scratch/papayv/Tarakihi/TARdn/09_Repeat/new_pipeline/V2P/3_Dfam_TETools_3d_run/TARdn_V2P_repeat_lib_actinodb_ad_and_denovo.fa
module load TandemRepeatsFinder/4.09
module load perl/CPAN/5.16
module load singularity/3.5.2
LIBDIR=/nfs/scratch/papayv/Tarakihi/TARdn/09_Repeat/new_pipeline/V2P/Libraries/libs/Libraries/
echo "download dfam-tetools.sh to download DfamTETools container if needed"
time echo "Create a Database for RepeatModeler"
singularity exec $sing BuildDatabase -name $genome1 $genome1_fasta
time echo "Run Repeat Modeler for de novo repeat detection. Also use the LTR detection pipeline"
singularity exec $sing RepeatModeler -database $genome1 -LTRStruct -pa $threads
time echo "change de novo repeat library to something clearer"
cp $dir/BMdn_assembly_V1_srn-families.fa $dir/BMdn_V1_denovo_repeat_lib.fa
time echo "compile de novo repeat libraries and Repeatmasker/Dfam/TAR db in one"
cat $dir/BMdn_V1_denovo_repeat_lib.fa $db_lib > $dir/BMdn_V1_repeat_lib_TARV2Pdb_and_denovo.fa
