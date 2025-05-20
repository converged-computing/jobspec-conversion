# Flux batch script equivalent

# Resources
# Flux uses a different syntax for resource requests.  We'll translate as best as possible.
# Nodes: 1
# Cores: 1 (ppn=1 in PBS translates to 1 core per node)
# Memory: 126GB
# Walltime: 96 hours

# Flux requires a --resources argument.  We'll specify nodes, cores, and memory.
# Flux doesn't have a direct equivalent to walltime, but it can be enforced externally.

# Job name
# Flux doesn't have a direct equivalent to -N, but we can set the job name in the script.
export JOB_NAME="RmvIndels"

# Email notifications (Flux doesn't directly support this, requires external setup)
# export EMAIL="rmoran@umn.edu"

# Array job (PBS -t 1-35)
# Flux uses a loop to achieve array job functionality.

for i in $(seq 1 35); do
  # Define the region file based on the array ID
  REGFOF="/home/mcgaughs/shared/References/2017-09_Astyanax_mexicanus/GATK_Regions_final.fof"
  REGION=$(sed "${i}q;d" ${REGFOF})
  REG_BNAME=$(basename ${REGION})
  REG_OUT=${REG_BNAME/.intervals/}

  # Change directory
  cd /home/mcgaughs/shared/Datasets/all_sites_LARGE_vcfs/filtered_surfacefish/combined_filtered/246Indvs_RepsMasked

  # Load modules
  module load bcftools
  module load python2
  export PATH=$PATH:/home/mcgaughs/rmoran/software/tabix-0.2.6

  # Execute the commands
  gunzip ${REG_OUT}_HardFiltered_246Indv_SurfaceRef_wInvar.RepsRemoved.vcf.gz

  python2 Remove_indels_for_VCFtools.py ${REG_OUT}_HardFiltered_246Indv_SurfaceRef_wInvar.RepsRemoved.vcf > Indels_to_remove/${REG_OUT}_indels_to_remove.bed

  bgzip ${REG_OUT}_HardFiltered_246Indv_SurfaceRef_wInvar.RepsRemoved.vcf
done