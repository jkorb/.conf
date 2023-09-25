#!/usr/bin/python3

from datetime import datetime
from datetime import date
from email import utils as mailutils
import mailbox
import os
import json
import html
from itertools import chain

# mail_icon = "\u2709 "
mail_icon = "\ueb1c "
smiley = "\U0001F60E"
mailbox_full = "\udb83\udd8d"
mailbox_empty = "\udb81\udeee"

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

    uu_md_path = os.path.join(os.environ['MAILDIR'], 'uu', 'INBOX')
    logica_md_path = os.path.join(os.environ['MAILDIR'], 'logica', 'Inbox')

    uu_mails = mailbox.Maildir(uu_md_path, create=False).values()
    logica_mails = mailbox.Maildir(logica_md_path, create=False).values()

    unread_mail = 0

    mail_list = chain(uu_mails,logica_mails)

    for mail in mail_list:

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
        output['text'] = "<span color='#e06c75'>\udb83\udd8d</span> " + str(unread_mail)

    print(json.dumps(output, indent=None, separators=(",",": ")))
