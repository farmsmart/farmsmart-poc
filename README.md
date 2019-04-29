# farmsmart

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## Firebase

You will need to get the google-services.json file from [Firebase](https://console.firebase.google.com/project/farmsmart-a0707/settings/general/android:amido.farmsmart)
Copy the file to /android/app/ folder


## Generating a release APK for upload to Google Play

Create local.properties and key.properties in /android/ folder.
The key properties should contain the following:
```
storePassword=<yourstorepassword>
keyPassword=<yourkeypassword>
keyAlias=<yourkey>
storeFile=<pathtoyourkeystorefile>.jks
```

Run the following command to generate an apk. Note flutter build name and build number determines the 
google play version
```
flutter build apk --build-name=99-RELEASE --build-number=99
```

Generated APK is found in
```
build\app\outputs\apk\release\app-release.apk
```
