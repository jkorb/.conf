#!/usr/bin/python3

import subprocess
import json

systemd_logo = "\u25CF\u200A\u25C0"
smiley = "\U0001F60E"

Green  = "#98c379"
Red    = "#e06c75"
Yellow = "#d19a66"

system_state_cmd = [ 'systemctl', 'show', '--property=SystemState' ]
failed_units_cmd = [ 'systemctl', 'list-units', '--failed' ]
timer_state_cmd = ['systemctl', '--user', 'show', '', '--property=ActiveState' ]
timers_list = ['isync.timer', 'vdirsyncer.timer']

def colorstr(str : str, color: str):
    styledstr = f"<span color='{color}'>{str}</span>"
    return(styledstr)

def call_process(cmd:list, out:dict):

    p = subprocess.run(cmd, stdout=subprocess.PIPE, stderr = subprocess.PIPE,text=True)

    try:
        p.check_returncode()
    except subprocess.CalledProcessError:
        rv = p.returncode
        stderr = p.stderr.strip()
        cmd_str = " ".join(cmd)
        out['tooltip'] = f"<span color='#e06c75'>Error</span>: \
            '{cmd_str}' returned {rv}\n\n stderr: {stderr}"
        print(json.dumps(out, indent=None, separators=(",",": ")))
        exit(0)

    return(p)

def main(**kwargs):
    out = {
        'text' : '',
        'tooltip' : ''
    }
    out.update(kwargs)

    system_state_proc = call_process(system_state_cmd, out)
    system_state = system_state_proc.stdout.strip().split('=')[1]

    system_state_cmd.insert(1,"--user")

    system_state__user_proc = call_process(system_state_cmd, out)
    system_state__user = system_state__user_proc.stdout.strip().split('=')[1]

    if system_state == "degraded":
        failed_units_proc = call_process(failed_units_cmd, out)
        failed_units = failed_units_proc.stdout.strip()
        out['tooltip'] += failed_units

    if system_state__user == "degraded":
        failed_units_cmd.insert(1,"--user")
        failed_units__user_proc = call_process(failed_units_cmd,out)
        failed_units__user = failed_units__user_proc.stdout.strip()

        if 'failed_units' in vars():
            out['tooltip'] += "\n\n"

        out['tooltip'] += failed_units__user

    timers_state = "running"

    for timer in timers_list:
        timer_state_cmd[3] = timer

        timer_state_proc = call_process(timer_state_cmd, out)
        timer_state = timer_state_proc.stdout.strip().split('=')[1]

        if timer_state == "inactive":
            if  'failed_units' in vars() or 'failed_units__user' in vars():
                out['tooltip'] += "\n\n"

            out['tooltip'] += timer + " inactive\n"
            timers_state = "degraded"

    if (system_state == "degraded" or
            system_state__user == "degraded" or
            timers_state == "degraded"):
        out['text'] += colorstr(systemd_logo, Red)

    if (system_state == "running" and
            system_state__user == "running" and
            timers_state == "running"):
        out['text'] += colorstr(systemd_logo, Green)
        out['tooltip'] += smiley + " Everything looks in order"

    if ((system_state != "running" and system_state != "degraded") or
            (system_state__user != "running" and system_state__user != "degraded") or
            (timers_state != "running" and timers_state != "degraded")):
        out['text'] += colorstr(systemd_logo, Yellow)
        out['tooltip'] += "System in unexpected state..."

    return(json.dumps(out, indent=None, separators=(",",": ")))

if __name__ == "__main__":
    print(main())
