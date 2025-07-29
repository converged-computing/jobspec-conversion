#!/bin/bash
#FLUX: --job-name=<%=
#FLUX: --urgency=16

<%
d = setdiff(names(resources), c("walltime", "memory"))
if (length(d) > 0L)
stopf("Illegal resources used: %s", collapse(d))
walltime = asInt(resources$walltime, lower = 1L, upper = 172800L)
memory = asInt(resources$memory, lower = 100L, upper = 64000L)
cmd = "R CMD BATCH --no-save --no-restore"
-%>
source /etc/profile
source /etc/profile.d/modules.sh
module load R/3.2mkl
<%= cmd %> "<%= rscript %>" /dev/stdout
