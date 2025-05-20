# Flux batch script equivalent

# Resources
--nodes=1
--cores=1
--memory=62G
--time=2:00:00
--job-name=fvecVCF

# Array job
--array=0-26

# Environment setup
source /home/mcgaughs/rmoran/miniconda3/etc/profile.d/conda.sh
conda activate diplo

# Change directory
cd /home/mcgaughs/shared/Software/diploSHIC

# Define variables
vcf="/home/mcgaughs/shared/Datasets/all_sites_LARGE_vcfs/filtered_surfacefish/filtered_snps/HardFilteredSNPs_250Samples"
Pop="Tinaja"
CMD_LIST="HardFiltered_All_Commands_fvecVCF.txt"

# Extract command based on array index
CMD="$(sed "${FLUX_ARRAY_INDEX}q;d" ${CMD_LIST})"

# Execute the command
eval ${CMD}