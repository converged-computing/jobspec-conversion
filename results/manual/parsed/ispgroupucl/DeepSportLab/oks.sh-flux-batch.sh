#!/bin/bash
#FLUX --job-name=cowy-blackbean-0942
#FLUX -c=2
#FLUX --urgency=16

python oks.py $@
