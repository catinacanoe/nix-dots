user:
let
    send_to = box: ":set delete=yes<enter><tag-prefix><save-message>=${box}<enter><sync-mailbox>:set delete=ask-yes<enter>";
    go_to = box: "<change-folder>=${box}<enter>";

    inbox = "INBOX";
    sent = "[Gmail]/Sent Mail";
    drafts = "[Gmail]/Drafts";
    trash = "[Gmail]/Trash";
    spam = "[Gmail]/Spam";

    colors = (import ./colors.nix);
in
with user;
''
set folder = "${folder}"
set smtp_url = "smtps://${email}@smtp.gmail.com:465"
set smtp_pass = `pass ${pass-entry}`

# non mbsync
# set folder = "imaps://${email}@imap.gmail.com:993"
# set imap_pass = `pass ${pass-entry}`

set from = "${email}"
set realname = "${name}"

set spoolfile = "+${inbox}"
set postponed = "+${drafts}"

mailboxes ="${inbox}" ="${sent}" ="${drafts}" ="${trash}" ="${spam}"

bind pager,attach,index g noop
bind index p noop
bind editor <space> noop

set sort=reverse-date
set beep=no
set sleep_time=0
set sidebar_visible
set index_format="%4C %Z %{%b %d %I:%M} %15.15L (%?l?%4l&%4c?) %s"
set confirmappend = no

bind index,pager N sidebar-toggle-visible
macro index,pager A "<sidebar-prev><sidebar-open>"
macro index,pager I "<sidebar-next><sidebar-open>"

bind index,pager w sync-mailbox

bind pager gg top
bind pager G bottom
bind pager n exit
bind pager i next-line
bind pager a previous-line

bind attach,index gg first-entry
bind attach,index G last-entry

bind index o display-message
bind index a previous-entry
bind index i next-entry

macro index pi "${send_to inbox}"
macro index pm "${send_to sent}"
macro index pd "${send_to drafts}"
macro index pt "${send_to trash}"
macro index ps "${send_to spam}"

macro index gi "${go_to inbox}"
macro index gm "${go_to sent}"
macro index gd "${go_to drafts}"
macro index gt "${go_to trash}"
macro index gs "${go_to spam}"

${colors}
''
