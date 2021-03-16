# CRChatBot
A Clash Royale Chat Bot for Twitch, written in Swift using Vapor, and built on top of NightBot.

# Introduction
This is a non-profit community project written by me (MahdiBM), for use of Clash Royale streamers on Twitch, and with help of the official Clash Royale API provided by Supercell.  
As of now its main Twtich-chat abilities are the followings:  
- [x] Searches for opponent's decks based on their trophies, and tells you their decks.
- [x] Searches for current rank info of the streamer and says it in the chat, or does the same for another player if you provide the bot with someone else's player tag.

# How to use?
After setting up the bot on your servers, and adding NightBot to your Twitch channel, type the following in your Twitch chat to enable the bot:   
```
!commands add !cr $(urlfetch https://www.yourdomain.com/twitch/api/v1/cr?arg1=$(1)&arg2=$(2)&arg3=$(3)&arg4=$(4)&arg5=$(5)&arg6=$(6)&arg7=$(7)&arg8=$(8)&arg9=$(9))
```

After an almost-immidiaite confirmation from NightBot saying that the command has been added successfully, The bot should be enabled.   
You can now command the bot on your Twitch chat. Type the following in your Twitch chat, for example:   
```
!cr help
```
Should be greeted with some kindof an error message saying that your channel is not white-listed! Don't worry though!    
To white-list any channels, you should know thier channel name. You can find it in thier url on Twitch, when you are watching that channel live.   
As an example, the url for my channel is `https://twitch.tv/mahdimmbm` so my channel name is `mahdimmbm`. Take the channel name and call an endpoint of your API to white-list the channel:   
```
https://yourdomain.com/twitch/api/v1/streamers/CHANNEL_NAME/add
```
Of course don't forget to replace `CHANNEL_NAME` with the real channel name, and don't forget to add your admin username and password as an Basic Authorization header for the request. The Basic Authorization credentials should have been set by you in the project files, and should be available in declaration file of `Authenticators.AdminAuthenticator` and named `ultimateOwnerAdmin`.    
Now your channel should be white-listed and you should be good to go. Type the following in Twitch chat:    
```
!cr help deck
```
You should see a message explaining how you can work with the `!cr deck` command.
