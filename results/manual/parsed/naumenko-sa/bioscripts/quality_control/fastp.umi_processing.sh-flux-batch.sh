#!/bin/bash
#FLUX: --job-name=schumacher
#FLUX: --queue=short
#FLUX: -t=18000
#FLUX: --urgency=16

fastp -i $1 -I $2 -o ${3}_1.fq.gz -O ${3}_2.fq.gz -h $3.fastp.html --umi --umi_loc --umi_len 8 --umi_prefix CELL --umi_skip
