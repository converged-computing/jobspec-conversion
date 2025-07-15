#!/bin/bash
#FLUX: --job-name=red-peas-7226
#FLUX: -n=16
#FLUX: -t=2400
#FLUX: --urgency=16

function cleanup {
    rm ${IOR_FILE}*
    rm $OUTPUT
    exit
}
trap 'cleanup' EXIT
part="other"
if [[ $SLURM_JOB_PARTITION == "milan" ]]; then
part="milan"
fi
OUTCSV="ior_benchmark_${part}_${SLURM_NNODES}.csv"
if [ ! -f $OUTCSV ]; then
   echo "time,w1_bw,w1_iops,w1_lat,r1_bw,r1_iops,r1_lat,w2_bw,w2_iops,w2_lat,r2_bw,r2_iops,r2_lat,w3_bw,w3_iops,w3_lat,r3_bw,r3_iops,r3_lat" >$OUTCSV
fi
OUTPUT="output-$SLURM_JOB_ID"
IOR_PATH=./src
IOR_FILE=IOR-file-${SLURM_JOB_ID}
srun $IOR_PATH/ior -w -a POSIX -F -C -e -g -k -b 4m -t 4m -s 1000 -o $IOR_FILE -v >$OUTPUT
srun $IOR_PATH/ior -r -a POSIX -F -C -e -g -k -b 4m -t 4m -s 1000 -o $IOR_FILE -v >>$OUTPUT
srun $IOR_PATH/ior -w -a MPIIO -c -C -g -b 8m -t 8m -k -s 1000 -o $IOR_FILE >>$OUTPUT
srun $IOR_PATH/ior -r -a MPIIO -c -C -g -b 8m -t 8m -k -s 1000 -o $IOR_FILE >>$OUTPUT
srun $IOR_PATH/ior -w -t 4m -k -a POSIX -F -b 16m -e -g -vv -C -D 45 -o ${IOR_FILE}.read.out -O stoneWallingWearOut=1 >>$OUTPUT
srun $IOR_PATH/ior -r -t 4k -z -a POSIX -F -b 16m -e -g -vv -C -D 45 -o ${IOR_FILE}.read.out >>$OUTPUT
echo -n  `date +"%D %H:%M:%S, "` >>$OUTCSV
cat $OUTPUT|grep "Stonewall(s) Stonewall(MiB)" -A1|grep -E "read|write"|awk '{ORS=""; print $4,",",$8,",",$10,","; ORS="\n"}'|sed 's/.$//' >>$OUTCSV
echo "">>$OUTCSV
