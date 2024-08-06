# SMTP server configuration
# Uncomment the following line and set your SMTP server address
# $smtpServer = "smtp.gmail.com" # Required
$smtpPort = 587 # Required

# Email domain used for the sender. The agent name will be appended to this domain (e.g. charl-e@nurgo-software.com)
$fromEmailDomain = "nurgo-software.com" # Required

# Email address to use as the reply-to address (only supported in PowerShell 6.2 and later)
# $replyTo = "support@nurgo-software.com" # Optional

# White list of email addresses that are allowed to be used as recipients
# $whiteList = @("*@nurgo-software.com", "bob@domain.com") # Optional

# Text added at the end of the email body
$postScriptum = "`n`nThis email was sent by a BrainSoup AI agent." # Optional