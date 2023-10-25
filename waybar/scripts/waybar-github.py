#!/usr/bin/python3

import json
import requests
import subprocess

url = 'https://api.github.com/notifications'
key_id = 'github.com/token-waybar-script'
github = '\udb80\udea4'
error_message = "<span color='#e06c75'>Error</span>"
notification_symbol = "\udb83\udd5a"
fronwie = '\U0001F622'

def colorstr(str : str, color: str):
    coloredstr = f"<span color='{color}'>{str}</span>"
    return(coloredstr)

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
    if kwargs:
        out.update(kwargs)

    p = call_process(['pass', key_id], out)

    auth = ('jkorb', p.stdout.strip())

    try:
        response = requests.get(url, auth=auth)
    except:
        out['text'] = github + "?"
        out['tooltip'] = f"{error_message}: couldn't get from {url}"
        print(json.dumps(out, indent=None, separators=(",",": ")))
        exit(0)

    notifications = json.loads(response.text)


    if len(notifications) == 0:
        # out['text'] = f"{github} {len(notifications)}"
        out['text'] = colorstr(github, "#A4A4A4" )
        out['tooltip'] = f"{fronwie} No unread notifications."
    else:
        out['text'] = github
        # out['text'] = f"<span color='#c678dd'>{github}</span> {len(notifications)}"
        for n in notifications:
            repo = n['repository']['full_name']
            title = n['subject']['title']
            type = n['subject']['type']
            n_str = f"{notification_symbol} {repo}: {title} ({type})"
            out['tooltip'] = '\n'.join([out['tooltip'],n_str])

    return(json.dumps(out, indent=None, separators=(",",": ")))

if __name__ == "__main__":
    print(main())
