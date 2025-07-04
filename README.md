# tellAboutIt

> "Instructions for living a life: Pay attention. Be astonished. Tell about it." – Mary Oliver

This repository contains the source code for **tellAboutIt**, an iOS application and Share Extension. The app lets you send videos to the [Twelvelabs](https://docs.twelvelabs.io/docs/get-started/introduction.md) API to generate engaging captions with hashtags and quickly share them to Instagram.

## Requirements

- macOS with the latest Xcode installed
- [XcodeGen](https://github.com/yonaskolb/XcodeGen) (`brew install xcodegen`)
- An Instagram account and the Instagram app installed on your iPhone
- A Twelvelabs API key

## Generating the Xcode project

The repository ships with a `project.yml` file. Run the following command in the repository root to generate the Xcode project:

```bash
xcodegen
```

This will create `TellAboutIt.xcodeproj` which you can open in Xcode.

## Building and running on a device

1. Open `TellAboutIt.xcodeproj` in Xcode.
2. Replace `YOUR_TEAM_ID` in `project.yml` with your Apple Developer Team ID and run `xcodegen` again.
3. Insert your Twelvelabs API key in `ShareViewController.swift` where `YOUR_API_KEY` is indicated.
4. Select your personal iOS device as the run target and build the project. The app installs an iOS Share Extension called **tellAboutIt**.
5. Record a video on your iPhone, open the share sheet, and choose **Share via tellAboutIt**. After the caption appears you can share it to Instagram via the provided share dialog.

## Publishing to the App Store

1. Ensure you have an active Apple Developer account and App Store listing.
2. Bump the version number in `project.yml` if needed and regenerate the project with `xcodegen`.
3. In Xcode, archive the **TellAboutIt** target and upload the build via the **Organizer** window.
4. Complete the app submission details in App Store Connect and submit for review.

More information about using Twelvelabs can be found in their [official documentation](https://docs.twelvelabs.io/docs/get-started/introduction.md).
