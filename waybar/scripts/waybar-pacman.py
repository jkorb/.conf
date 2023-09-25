#!/usr/bin/python3

import json
import subprocess

package = '\udb80\udfd4'

checkupdates_cmd = ['checkupdates']
yay_check_cmd = ['yay', '-Qua']

def main(**kwargs):
    out = {
        'text' : '',
        'tooltip' : ''
    }
    if kwargs:
        out.update(kwargs)

    p = subprocess.Popen(yay_check_cmd, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    q = subprocess.Popen(checkupdates_cmd, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    q_out, q_err = q.communicate()

    if q.returncode == 1:
        out['text'] = f"{package} ??"
        out['tooltip'] = f"<span color='#e06c75'>Error</span>: 'checkupdates' returned {q.returncode}\n\n stderr: {q_err}"
        print(json.dumps(out, indent=None, separators=(",",": ")))
        exit(0)

    if q_out:
        count = q_out.count('\n')
        out['tooltip'] = q_out
    else:
        count = 0

    p_out, p_err = p.communicate()

    if p.returncode != 0:

        if count > 0:
            out['text'] = f"<span color='#61afef'>{package}</span> {count}??"
        else:
            out['text'] = f"{package} {count}"

        yay_str = f"<span color='#e06c75'>Error</span>: 'yay -Qua' returned {p.returncode}\n\n stderr: {p_err}"

        out['tooltip'] = "\n".join([out['tooltip'], yay_str])
        print(json.dumps(out, indent=None, separators=(",",": ")))
        exit(0)

    if p_out:
        count = p_out.count('\n') + count
        out['tooltip'] = '\n'.join([out['tooltip'], p_out]).strip()

    if count > 0:
        out['text'] = f"<span color='#61afef'>{package}</span> {count}"
    else:
        out['text'] = f"{package} {count}"

    return(json.dumps(out, indent=None, separators=(",",": ")))

if __name__ == "__main__":
    print(main())
