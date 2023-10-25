#!/usr/bin/python3

from datetime import datetime, timedelta, date
import json
import html
import sys

logo_blank    = "\udb80\udcee"
logo_event    = "\udb80\udced"
logo_reminder = "\udb80\udc20"
clock_item    = "\U000023F0"
continue_logo = "\U000021AA"
calendar_item = "\U0001F4C5"
smiley        = "\U0001F60E"
error_message = "<span color='#e06c75'>Error</span>"

khal_format = "{{\"start\":\"{start}\",\"end\":\"{end}\",\"title\":\"{title}\"}}"
khal_cmd = ['khal', 'list', 'now', '23:59', '--format', khal_format, '--day-format', '']

def sanitize_title(title:str):
    title  = html.escape(title)
    return(title)

def call_process(cmd:list, out:dict):
    import subprocess

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

    cur_time = datetime.now()

    reminder_flag = 0

    try:
        p = call_process(khal_cmd, out)

        if not p.stdout:
            out['text'] = f"{cur_time.strftime('%a, %b %d, %R')}"
            out['tooltip'] = f"{smiley} No upcoming appointments."
            return(json.dumps(out, indent=None, separators=(",",": ")))


        out['text'] = f"{cur_time.strftime('%a, %b %d, %R')}"
        stdout_lines = p.stdout.splitlines()

        for line in stdout_lines:
            appt = json.loads(line)

            try:
                start = datetime.strptime(appt['start'], '%d/%m/%Y %H:%M')
            except ValueError:
                try:
                    start = datetime.strptime(appt['start'], '%d/%m/%Y').date()
                except Exception as e:
                    start = cur_time
                    print(str(e), file=sys.stderr)

            try:
                end = datetime.strptime(appt['end'], '%d/%m/%Y %H:%M')
            except ValueError:
                try:
                    end = datetime.strptime(appt['end'], '%d/%m/%Y').date()
                except Exception as e:
                    end = cur_time
                    print(str(e), file=sys.stderr)

            title = sanitize_title(appt['title'])

            if isinstance(start,datetime):
                if ((start - timedelta(minutes=15) <= cur_time) and
                    (cur_time <= start)):
                    reminder_flag += 1
                    # out['text'] = " ".join([out['text'], f"<span color='#e06c75'>{logo_reminder}</span>"])
                out['tooltip'] = "\n".join([
                                            out['tooltip'],
                                            f"{clock_item} {start.strftime('%H:%M')}-{end.strftime('%H:%M')}: {title}"])
            elif isinstance(start,date):
                if end == date.today():
                    out['tooltip'] = "\n".join([out['tooltip'], f"{calendar_item} {title}"])
                elif end >= date.today():
                    out['tooltip'] = "\n".join([out['tooltip'], f"{calendar_item} {title} {continue_logo}"])
                else:
                    out['tooltip'] = "\n".join([out['tooltip'], f"{error_message} processing appointment"])
            else:
                out['tooltip'] = "\n".join([out['tooltip'],f"{error_message} processing appointment"])


        if reminder_flag > 0:
           out['text'] = " ".join([out['text'], f"<span color='#cf6679'>{logo_reminder}</span>"])

    # This is not really pythonic, but its PARAMOUNT, that this script returns a
    # 0 exit code, unless thing go CATASTROPHICALLY wrong.
    except Exception as e:
        print(str(e), file=sys.stderr)
    finally:
        return(json.dumps(out, indent=None, separators=(",",": ")))

if __name__ == "__main__":

    print(main())
