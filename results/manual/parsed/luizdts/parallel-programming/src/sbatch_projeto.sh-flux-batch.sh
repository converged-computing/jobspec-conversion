#!/bin/bash
#FLUX: --job-name=Pascal_svd
#FLUX: --exclusive
#FLUX: --queue=amd-512
#FLUX: -t=10
#FLUX: --priority=16

$cores="1,2,4,8,16,32,64,128"
pascalanalyzer -t aut -c $cores -i "./snapshot_u1_2000.txt","./snapshot_u1_4000.txt",\
"./snapshot_u1_8000.txt","./snapshot_u1_16000.txt","./snapshot_u1_20000.txt",\
"./snapshot_u1_24000.txt","./snapshot_u1_30000.txt", "./snapshot_u1_32000.txt" -o SVD.json ./svd
