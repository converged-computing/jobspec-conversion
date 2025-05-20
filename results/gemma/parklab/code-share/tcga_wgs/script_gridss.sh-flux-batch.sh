# Flux batch script

--nodes=1
--cores=8
--time=5:00:00
--partition=medium
--memory=48G

# Output and error files
--output=log/gridss_%j.out
--error=log/gridss_%j.err

# Array job (if needed, adjust as necessary)
# --array=2-2

# Environment setup (mimic bash script)
export GRIDSS_JAR_PATH=/usr/local/bin/gridss-2.13.2.jar
export TUMOR_ID='TCGA-HC-A6HX-01A-11D-A755-36'
export REFERENCE_ID='TCGA-HC-A6HX-10A-01D-A755-36'
export OUT_PATH=/n/data1/hms/dbmi/park/dglodzik/hmf_gridss_test/${TUMOR_ID}/
export GRIDSS_PATH=$OUT_PATH/gridss/
export TEMP_FOLDER=/n/scratch/users/d/dg204/temp/

mkdir -p "$OUT_PATH"
mkdir -p "$GRIDSS_PATH"

export gridssJvmHeap=44g
export otherjvmheap=4g
export gridssOutput="$GRIDSS_PATH/$TUMOR_ID.gridss.sv.vcf"
export gridssAssembly=$TEMP_FOLDER/$TUMOR_ID.bam
export gridssThreads=8
export gridssTmpDir=$TEMP_FOLDER
export reference=/n/data1/hms/dbmi/park/dglodzik/TCGA/reference/GRCh38.d1.vd1.fa
export TUMOR_BAM=/n/data1/hms/dbmi/park/dglodzik/TCGA/5555b571-6e03-4564-a0cf-05996b3f52c5/2f5d2e1e-110d-4058-bfe5-17d40b5f2583_wgs_gdc_realn.bam
export REFERENCE_BAM=/n/data1/hms/dbmi/park/dglodzik/TCGA/a550b72d-4290-4def-be69-ba40f36b71f9/7718ad9b-1ded-4d0c-abe8-3095b73e5cde_wgs_gdc_realn.bam

singularity exec -B /n/scratch,/n/data1 /n/app/singularity/containers/gridss_cgap.sif \
gridss \
-r ${reference} \
--jar  ${GRIDSS_JAR_PATH} \
--jvmheap ${gridssJvmHeap} \
--otherjvmheap ${otherjvmheap} \
--output ${gridssOutput} \
--assembly ${gridssAssembly} \
--threads ${gridssThreads} \
--workingdir ${gridssTmpDir} \
--labels ${TUMOR_ID},${REFERENCE_ID} \
$TUMOR_BAM \
$REFERENCE_BAM