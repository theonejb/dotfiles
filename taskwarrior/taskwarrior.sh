# Task warrior setup
alias t=task

# Setup task warrior to dispaly the task list every x minutes using the ZSH periodic callback
# We need a function because the periodic callback only works with shell functions
function next_task {
  # Only run the command if we have some tasks to run
  /Users/asadjb/.show_tasks.py >& /dev/null
  if [ $? -eq 0 ]; then
    /Users/asadjb/.show_tasks.py
    touch /Users/asadjb/.task_warrior_once_lock
  fi
}
periodic_functions=('next_task')
let "callback_period = 60 * 15"  # 5 minutes
PERIOD=$callback_period
