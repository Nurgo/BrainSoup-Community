This is a simple example of how you can create a custom tool with PowerShell
scripts to let your BrainSoup agents use third party services.

In this case, we are using Discord webhooks to send messages to a Discord
server.

To use this tool, you need to:
1. Create a Discord server.
2. Create a webhook named 'BrainSoup' in the server:
   Server Settings -> Integrations -> Webhooks -> New Webhook.
3. Copy the webhook URL.
4. Edit the "config.ps1" file and add the webhook URL.