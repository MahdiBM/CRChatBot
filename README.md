# CRChatBot
A Clash Royale Chat Bot for Twitch, written in Swift using Vapor 4, and built on top of NightBot.

# Introduction
This is a non-profit community project written by me (MahdiBM), for use of Clash Royale streamers on Twitch, and with help of the official Clash Royale API provided by Supercell. It is currently being used by 10+ Clash Royale streamers on Twitch.    
As of now its main Twitch-chat abilities are the followings:  
- [x] Searches for opponent's decks based on their trophies, and tells you their decks.
- [x] Searches for current rank info of the streamer and says it in the chat, or does the same for another player if you provide the bot with someone else's player tag.

# I only trust my own eyes!
Want to see with your own eyes how this works in a real Twitch chat? You can head to [my Twitch channel](https://twitch.com/mahdimmbm) and use its chat to see how the command works (for clarification, I don't stream). Type `!cr help` and the command should respond to you.   
Some general things to note when using the command in a Twitch chat:
* NightBot has a cooldown for every command. That is mostly due to the fact that Twitch's API has limits for number of requests NightBot can make, so NightBot needs to only answer a reasonable amount of commands so it doesn't exceed that limit. This cooldown appears to be a little bit too long for normal chatters (10 +- 5 seconds), but if you are a moderator in a channel, it should only be about 5 seconds.
* If something goes wrong in the app, or the app takes more than 10s to respond to NightBot, you'll see an error message from NightBot. If NightBot doesn't respond to your command at all, then its just NightBot ignoring you and there is nothing wrong with the app.

# Making it work: 1- Repairing the project
As one could guess, there are some credentials used in this project that are secrets, and only the one that wants to deploy the project should know them. These info are replaced with placeholders that you'll need to fill.   
There are also some other things you'll need to configure as well, here are most of them:    
* In `Authenticators.AdminAuthenicator` fill in the `username` and `password` placeholders. These username and password pair must be passed into your request as a Basic Authorization header if you are making a call to one of the admin-only routes.
* In `CRAPIRequest`, fill `crapiToken` with your own token. Read `CRAPIRequest.crapiToken`'s explanation for more info.
* In `OAuth.Twitch`, fill the credentials with your own's. Read `OAuthable`'s explanations for more info.
* In the Configuration file, fill in the database info.
* If there are other placeholders remaining, don't hesitate to fill those as well.
* Last step; In `/redis` directory, open `redis.conf` file, and search for `dir path/to/your/redis/directory`. Replace `path/to/your/redis/directory` with the exact path to your `/redis` directory. As an example, my own specific path to `/redis` directory is `/home/ubuntu/CRChatBot/redis/`.

# Making it work: 2- How to install?
Having at least a little bit of knowledge about how command line tools work and how to set up a server is recommended.   
[Google](https://google.com) and [Vapor docs](https://docs.vapor.codes/4.0/) are your friends.   
I won't go into details, but i'll try to mention all the steps that might not be 100% needed, but are what i'd do.   
I'll assume you are using Ubuntu.      
* Get a domain and a droplet and set your domain to point to your droplet on your provider's panel.  
  * You can get a server from AWS (Amazon), CloudFlare or Digital Ocean (or any other provider).   
  * Because of how Clash Royale API works, your server needs to have an static IP (So Heroku droplets with non-static IPs wil not work.)   
  * If you need it to work with non-static IPs, you can head to [RoyaleAPI dev server](http://discord.royaleapi.dev) and You'll find a free proxy service there.   
  Here i'll assume you are not using that proxy service, but most things should be the same even if you are using that service.
* Install these tools: [Swift](https://swift.org), [Supervisor](https://docs.vapor.codes/4.0/deploy/supervisor/), [Nginx](https://docs.vapor.codes/4.0/deploy/nginx/), [Docker](https://docs.vapor.codes/4.0/deploy/docker/), [Redis](https://redis.io).    
* For the next step, make sure you have set up the tools on the last step currectly. Some general notes:  
  * Swift should be added to your PATH.
  * Nginx should be set up to accept requests from the outside world and guide them to this app.
  * Supervisor should be set up to take care of running the app.
  * Docker is needed to make a Postgres database for the app to use. 
  * Redis is also needed as the faster, in-memory database of the app. The configuration file for the redis database is included in the project's files in directory `/redis` under name `redis.conf`.
* After repairing the project (which was explained above), clone this app on your server.
  * Change you directory to the directory of this app.
  * Set up your Postgres database on Docker. Here's an example:
    ```
    docker run --name twitch -e POSTGRES_DB=twitch -e POSTGRES_USER=twitch -e POSTGRES_PASSWORD=password -p 5433:5432 -d postgres
    ```
  * Do `swift build` to build the app, then `swift run Run migrate` to run the migrations on the Postgres database.
  * After setting up your Supervisor to take care of running your app, the redis database, and docker's postgres database all-together, you can reload Supervisor and your app should be good to go.

# Making it work: 3- How to use?
After setting up the bot on your servers, and adding NightBot to your Twitch channel, type the following in your Twitch chat to enable the bot:   
```
!commands add !cr $(urlfetch https://www.yourdomain.com/twitch/api/v1/cr?arg1=$(1)&arg2=$(2)&arg3=$(3)&arg4=$(4)&arg5=$(5)&arg6=$(6)&arg7=$(7)&arg8=$(8)&arg9=$(9))
```
Note that you must of-course replace `yourdomain.com` with your own domain.   

After an almost-immediate confirmation from NightBot saying that the command has been added successfully, The bot should be enabled.   
You can now command the bot on your Twitch chat. Type the following in your Twitch chat, for example:   
```
!cr help
```
You should be greeted with some kind-of an error message saying that your channel is not white-listed! Don't worry though!    
To white-list any channels, you only need to know their channel name. You can find it in their url on Twitch, when you are watching that channel live.   
As an example, the url for my channel is `https://twitch.tv/mahdimmbm` so my channel name is `mahdimmbm`. Take the channel name and call this endpoint to white-list the channel (Channel name should be all lower-cased):   
```
https://yourdomain.com/twitch/api/v1/streamers/CHANNEL_NAME/add
```
If your twitch channel is offline, you'll need to call the following endpoint as well, so you disable online-checks for your channel:   
```
https://yourdomain.com/twitch/api/v1/streamers/CHANNEL_NAME/toggleOnlineChecks
```
Don't forget to replace `CHANNEL_NAME` with the real channel name, and don't forget to add your admin username and password as a Basic Authorization header for the request. The Basic Authorization credentials should have been set by you in the project files, and should be available in declaration file of `Authenticators.AdminAuthenticator` and named `ultimateOwnerAdmin`.  
Now your channel should be white-listed and you should be good to go. Type the following in Twitch chat:    
```
!cr help deck
```
You should see a message explaining how you can work with the `!cr deck` command.

# Technologies used
This app is a faily simple app, but its not as simple as one might think by just reading the introduction! Some stuff used to form the app:  
* Fluent; to work with the Docker PostgreSQL database.
* Queues; doing ~3 tasks every second, to gather some required data about players.
* Redis; as a faaast in-memory database, to save 1000s of players to in every second.
* SwiftProtobuf; for high performance JSON decoding.
* XCTVapor; to write tests!
