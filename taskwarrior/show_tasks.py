#!/usr/bin/env python
import os
import subprocess
import sys
import time


REDISPLAY_LIST_AFTER_MINUTES = 15

# Based on when was the last time we showed the task list, decide if we should show it now. This is needed because
# when using the `periodic` Zsh callback, the $PERIOD is tracked once per shell session, not globally. This means that
# if I have two tmux panes, they both end up showing the task list once the $PERIOD is over. This lock file is a mean
# to fix that. The access time is updated by the Zsh script, because this script is called twice. Once to check if
# there are any tasks to show and once to show the list. If we change the mtime here, we would need to add a parameter
# to tell us to not modify the mtime of the file the first time around. I'm too lazy for that.
LOCK_FILE_PATH = '/Users/asadjb/.task_warrior_once_lock'
try:
    lock_file_stats = os.stat(LOCK_FILE_PATH)
except OSError:
    open(LOCK_FILE_PATH, 'wb').close()
else:
    list_display_seconds_diff = time.time() - lock_file_stats.st_mtime
    if list_display_seconds_diff < (REDISPLAY_LIST_AFTER_MINUTES * 60):
        # This signals our periodic callback function to not show the task list
        sys.exit(1)

return_code = subprocess.call(["task", "next"])

# Return the same return code as the task warrior command
sys.exit(return_code)
