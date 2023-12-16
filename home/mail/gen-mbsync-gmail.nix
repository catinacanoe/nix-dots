user:
with user;
''
IMAPStore ${id}-remote
Host imap.gmail.com
Port 993
User ${email}
PassCmd "pass ${pass-entry}"
SSLType IMAPS
CertificateFile /etc/ssl/certs/ca-certificates.crt

MaildirStore ${id}-local
Path ${folder}
Inbox ${folder}INBOX
Subfolders Verbatim

Channel ${id}
Far :${id}-remote:
Near :${id}-local:
Create Both
Expunge Both
Patterns *
SyncState *
''
