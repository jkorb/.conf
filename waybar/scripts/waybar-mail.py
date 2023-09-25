#!/usr/bin/python3

from datetime import datetime
from datetime import date
from email import utils as mailutils
import mailbox
import os
import json
import html

# mail_icon = "\u2709 "
mail_icon = "\ueb1c "
smiley = "\U0001F60E"
mailbox_full = "\ueb1c"
mailbox_empty = "\ueb1b"

def format_time(timestamp):

    daytime =  datetime.fromtimestamp(timestamp)
    day = daytime.date()
    today = date.today()

    if today == day:
        return(daytime.strftime('%H:%M'))
    else:
        return(daytime.strftime('%a %d'))

def format_sender(sender):
    parsed_sender = mailutils.parseaddr(sender)
    return(parsed_sender[0] + ": ")


def sanitize_string(s:str):
    s = html.escape(s)
    return(s)

def format_subject(subject):
    subject = sanitize_string(subject)
    subject = subject[:80] + '...' if len(subject) > 80 else subject
    return(subject)

if __name__ == "__main__":

    output = {
        "text" : "",
        "tooltip" : ""
    }

    md_path = os.path.join(os.environ['MAILDIR'], 'uu', 'INBOX')
    md = mailbox.Maildir(md_path, create=False)

    unread_mail = 0

    for mail in md.values():

        flags = mail.get_flags()
        if "S" not in flags:
            formated_time = format_time(mail.get_date())
            formated_sender = format_sender(mail["From"])
            formated_subject = format_subject(mail["Subject"])
            if unread_mail > 0:
                output['tooltip'] += "\n"
            output['tooltip'] += mail_icon + formated_time + " " + formated_sender + " " + formated_subject
            unread_mail += 1

    if unread_mail == 0:
        output['text'] = mailbox_empty + " " + str(unread_mail)
        output['tooltip']= smiley + " No unread emails."
    else:
        output['text'] = "<span color='#e06c75'>\ueb1c</span> " + str(unread_mail)

    print(json.dumps(output, indent=None, separators=(",",": ")))
