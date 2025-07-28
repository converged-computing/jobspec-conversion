#!/bin/bash
#FLUX: --job-name=test
#FLUX: -c=127
#FLUX: --queue=node
#FLUX: --urgency=16

./mr_st 35 36
./BPtab 35
./mr_BP 35 35
