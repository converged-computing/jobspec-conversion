#!/bin/bash
#FLUX: --job-name=<%=
#FLUX: --urgency=16

R CMD BATCH --no-save --no-restore "<%= rscript %>" /dev/stdout
