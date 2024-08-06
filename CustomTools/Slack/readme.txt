This is a simple example of how you can create a custom tool with PowerShell
scripts to let your BrainSoup agents use third party services.

In this case, we are using Slack webhooks to send messages to a Slack channel.

To use this tool, you need to:
1. Create a Slack channel.
2. Create a webhook for the channel:
   https://my.slack.com/apps/A0F7XDUAZ-incoming-webhooks
3. Copy the webhook URL.
4. Edit the "config.ps1" file and add the webhook URL.