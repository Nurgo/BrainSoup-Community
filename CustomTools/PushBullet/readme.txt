This is a simple example of how you can create a custom tool with PowerShell
scripts to let your BrainSoup agents use third party services.

In this case, we are using PushBullet which is a free service that lets you send
push notifications to your phone, or SMS messages to any phone number by using
your phone as a gateway.

To use this tool, you need to:
1. Create a PushBullet account at https://www.pushbullet.com
2. Install the PushBullet app on your phone.
3. Get an API key from PushBullet by going to https://www.pushbullet.com/account
and clicking on "Create Access Token".
4. Edit the "config.ps1" file and add your API key.