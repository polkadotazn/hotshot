- technologies
- name
- wireframes
-AVFoundation
-firebase
-Swift
-Xcode
-Aws

https://github.com/rizwankce/Camera/

# Hot Shot
#### A phone app for sharing events and moments in your area
## Background and Overview
With this app, users can capture moments via snippets of video and share them locally. Other people can then upvote or downvote videos, as well as search for videos by category. Users can gain karma by sharing videos that are popular among other users.
## Functionality and MVP
- [ ] User profile displaying karma/points, picture
- [ ] User can take a video and upload it
- [ ] Share videos with other users
- [ ] Main feed organizes videos by most popular or most recently uploaded
- [ ] Users can upvote/downvote other people's videos
##### Bonus:
- [ ] Restrict video views to a radius, implementing Google Maps API
- [ ] Videos have a category label
- [ ] Users can search videos by category
- [ ] Top users
## Technologies & Technical Challenges
##### Backend: Firebase
##### Frontend: Swift (application logic), Xcode (UI implementation)
##### Frameworks: AVFoundation (for camera access, allows Swift to communicate with camera hardware)
Challenges
* accessing camera using AVFoundation and building a GUI to allow users to take videos within the app
* integration of Google maps and utilizing geolocation
* periodic deletion of videos
* integrating backend language with Firebase
## Wireframes
![camera view](https://raw.githubusercontent.com/polkadotazn/hotshot/master/Hotshot_Wireframes/Camera.png)
![home feed](https://github.com/polkadotazn/hotshot/blob/master/Hotshot_Wireframes/Home_Feed.png?raw=true)
![map](https://github.com/polkadotazn/hotshot/blob/master/Hotshot_Wireframes/Map.png?raw=true)
![user profile](https://github.com/polkadotazn/hotshot/blob/master/Hotshot_Wireframes/User_Profile.png?raw=true)
![watching a story](https://github.com/polkadotazn/hotshot/blob/master/Hotshot_Wireframes/Watching_story.png?raw=true)
![explore](https://github.com/polkadotazn/hotshot/blob/master/Hotshot_Wireframes/Explore.png?raw=true) *Bonus
## Accomplished Over the Weekend
We finished the wireframes, got more familiar with our new technologies, set up the dev environment, and began creating GUI for video uploads.
## Group Members & Work Breakdown
#### Day 1
* UserAuth for Firebase - Louisa
* User profile view - Emmanuel
* Work on setting up in-app video camera, utilizing AVFoundation to activate camera hardware and capture video/setting up GUI - Sam
#### Day 2
* User profile backend - Louisa
  * username
  * avatar
  * karma
* Main feed view - Emmanuel
* Finish setting up in-app video camera: style GUI - Sam
#### Day 3
* Upvotes and downvotes - Louisa
* Uploading and deleting videos - Sam
* Main feed view - Emmanuel
#### Day 4
* Main feed logic - Emmanuel
  * Sorting videos by recent and upvotes - Louisa
* Sharing and viewing videos - Sam
#### Day 5
* Bug fixes and overflow work
#### Day 6
* About me
* Improve look and feel of app
* Location-based 
