# Welcome to Gomiland! 

Gomiland is a recycling focused game where players explore the city of Gomiland and help pick up and sort trash. Learn about the Gomiland's effort to be a sustainable city by talking to the people and reading the signs!

From the main menu you can:
1. Start a new game
2. Redeem codes to add items in the game (see below)
3. Sign in or create an account (required for features 4-6)
4. Load saved
5. Add and accept friend requests
6. View high scores

#How to set up

1. Install Flutter on your device.
2. Download the repo
3. Run `flutter pub get`

**Web**
1. Start a Chrome window `flutter run -d chrome --web-renderer canvaskit`

**Android**
1. Enable Android developer mode
2. Attach Android phone
3. Check device id `flutter devices`
4. Run on Android device `flutter run -d <device_id>`

**iOS**
1. Attach iPhone/ iPad
2. Open Xcode
3. Choose _Open Existing Project_
4. Select runner file _./ios/Runner.xcworkspace_ (not .xcodeproj)
5. Select target device
6. Run on target device
7. If it states "Untrusted developer, ...", allow the app to be run by going to Settings > General > Device management > trust profile
8. Run again

To install the app and use it without plugging in"
1. Attach iPhone/ iPad
2. Run `flutter run --release`

If there is an error caused by a conflict in pod file:
1. Delete file _ios/Podfile.lock_ in root folder
2. run `cd ios && pod install && cd ..`

#Redemption codes

These redemption codes are given out to NGOs/ recycling centres/ companies to give players when they contribute to sustainability.
These codes are to unlock objects that players can buy in their zen garden.
For the purposes of illustration, the codes are given below for the demo
1. Code: '1234' Item: Bonsai 1
2. Code: '2345' Item: Bonsai 2
3. Code: '3456' Item: Bonsai 3
4. Code: '4567' Item: Bonsai 4
5. Code: 'qwer' Item: Rock 1
6. Code: 'wert' Item: Rock 2
7. Code: 'erty' Item: Rock 3

# Credits

**Code Development and gameplay**
Lim Chee Keen _limcheekeen.63@gmail.com_

**Art and Design**
Hong Yeu Wing
Amelia Yeo
Lim Chee Keen

**Music and Sound**
Parker Clendening
Iori Goto

Thanks for playing!
