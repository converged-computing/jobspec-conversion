#!/bin/bash
#FLUX: --job-name=red-kerfuffle-8144
#FLUX: -t=3600
#FLUX: --urgency=16

PROJ_DIR="$HOME/projects/1a"
BIN_DIR="$PROJ_DIR/bin"
SRC_DIR="$PROJ_DIR/src"
LOGS_DIR="$PROJ_DIR/logs"
module load gcc
cd "$SRC_DIR"
gcc -O3 -march=native -DSTREAM_TYPE=double -DSTREAM_ARRAY_SIZE=8000000 \
	-DNTIMES=20 stream.c -o "$BIN_DIR/stream_c.exe"
"$BIN_DIR/stream_c.exe"
