#!/bin/bash
#FLUX: --job-name=STREAM_MULTI_TESTING
#FLUX: -N=2
#FLUX: --queue=thor
#FLUX: -t=1800
#FLUX: --urgency=16

export STREAM_ARRAY_SIZE='22000000'
export OMP_NUM_THREADS='1   # 16 cores per socket'
export NP_VALUE='2'
export STREAM_DIR='$(pwd)'
export OUTPUT_DIR='$STREAM_DIR/outputs_mc_o3_2n'
export OUTPUT_FILE='$OUTPUT_DIR/multi_node_output_$(date +"%d-%m-%y")_$(date +"%T").txt'

export STREAM_ARRAY_SIZE=22000000
export OMP_NUM_THREADS=1   # 16 cores per socket
export NP_VALUE=2
export STREAM_DIR=$(pwd)
export OUTPUT_DIR=$STREAM_DIR/outputs_mc_o3_2n
if [ ! -d $OUTPUT_DIR ]; then
    mkdir $OUTPUT_DIR
fi
export OUTPUT_FILE=$OUTPUT_DIR/multi_node_output_$(date +"%d-%m-%y")_$(date +"%T").txt
if [[ -f $OUTPUT_FILE ]]; then
    rm $OUTPUT_FILE
    touch $OUTPUT_FILE
else
    touch $OUTPUT_FILE
fi
make stream_oshmem.exe          CFLAGS="-fopenmp -O3"       PFLAGS=""
i=1
for i in {1..5}
do
        echo "==========================================================================" >> $OUTPUT_FILE
        echo "    STREAM BENCHMARK RUN ON "$(date +"%d-%m-%y")" AT "$(date +"%T")         >> $OUTPUT_FILE
        echo "==========================================================================" >> $OUTPUT_FILE
        echo "-------------------------------------------------------------" >> $OUTPUT_FILE
        echo "                          OpenSHMEM"                           >> $OUTPUT_FILE
        echo "-------------------------------------------------------------" >> $OUTPUT_FILE
        if oshrun -np $NP_VALUE stream_oshmem.exe >> $OUTPUT_FILE; then
                echo "OpenSHMEM impl finished."
        else
                echo "FAILED TO RUN!" >> $OUTPUT_FILE
                echo "OpenSHMEM impl FAILED TO RUN!"
        fi
        echo "Done! Output was directed to $OUTPUT_FILE"
done
make clean
