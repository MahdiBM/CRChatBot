# CRChatBot
A Clash Royale Chat Bot for Twitch, written in Swift using Vapor 4, and built on top of NightBot.

# Introduction
This is a non-profit community project written by me (MahdiBM), for use of Clash Royale streamers on Twitch, and with help of the official Clash Royale API provided by Supercell.  
As of now its main Twtich-chat abilities are the followings:  
- [x] Searches for opponent's decks based on their trophies, and tells you their decks.
- [x] Searches for current rank info of the streamer and says it in the chat, or does the same for another player if you provide the bot with someone else's player tag.

# How to install?
Having at least a little bit of knowledge about how command line tools work and how to set up a server is recommended.   
[Google](https://google.com) and [Vapor docs](https://docs.vapor.codes/4.0/) are your friends.   
I won't go into details, but i'll try to mention all the steps that might not be 100% needed, but are what i'd do.   
I'll assume you are using Ubuntu.      
* Get a domain and a droplet and set your domain to point to your droplet on your provider's panel.  
  * You can get a server from AWS (Amazon), CloudFalre or Digital Ocean (or any other provider).   
  * Because of how Clash Royale API works, your server needs to have an static IP (So Heroku droplets with non-static IPs wil not work.)   
  * If you need it to work with non-static IPs, you can head to [RoyaleAPI dev server](http://discord.royaleapi.dev) and You'll find a free proxy service there.   
  Here i'll assume you are not using that proxy service, but 98% of things should be the same even if you are using that service.
* Install these tools: [Swift](https://swift.org), [Supervisor](https://docs.vapor.codes/4.0/deploy/supervisor/), [Nginx](https://docs.vapor.codes/4.0/deploy/nginx/), [Docker](https://docs.vapor.codes/4.0/deploy/docker/), [Redis](https://redis.io).    
* For the next step, make sure you have set up the tools on the last step currectly. Some general notes:  
  * Swift should be added to your PATH.
  * Nginx should be set up to accept requests from the outside world and guide them to this app.
  * Supervisor should be set up to take care of running the app.
  * Docker is needed to make a Postgres database for the app to use. 
  * Redis is also needed as the faster, in-memory database of the app.
* After filling the placeholders that are in the app's files, clone this app on your server.
  * Change you directory to the directory of this app.
  * Set up your Postgres database on Docker. Here's an example:
    ```
    docker run --name twitch -e POSTGRES_DB=twitch -e POSTGRES_USER=twitch -e POSTGRES_PASSWORD=password -p 5433:5432 -d postgres
    ```
  * Do `swift build` to build the app, then `swift run Run migrate` to run the migrations on the Postgres database.
  * After setting up your Supervisor to take care of running your app, the redis database, and docker's postgres database together, you can reload Supervisor
    and your app should be good to go.

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
