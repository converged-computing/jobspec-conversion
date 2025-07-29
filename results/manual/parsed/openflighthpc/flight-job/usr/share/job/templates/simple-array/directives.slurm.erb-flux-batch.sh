#!/bin/bash
#FLUX: --job-name=<%=
#FLUX: --urgency=16

<% if questions.merge_stderr_with_stdout.answer.to_s == 'yes' -%>
<% else -%>
<% end -%>
<% if questions.job_name.answer.blank? -%>
<% else -%>
<% end -%>
<% if questions.notification_wanted.answer == 'yes' -%>
<% else -%>
<% end -%>
<% if questions.notification_wanted.answer == 'yes' -%>
<% else -%>
<% end -%>
