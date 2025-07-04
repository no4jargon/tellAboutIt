# ShareExtension

This folder contains the iOS Share Extension for the tellAboutIt app. The extension receives a video from the iOS share sheet, sends it to the Twelvelabs API, then presents a share sheet so you can post the captioned video to Instagram.

## Configuration

1. Add your Twelvelabs API key in `ShareViewController.swift`.
2. Ensure the Instagram app is installed on your device.

The extension is invoked from the Photos app (or any other app that supports video sharing) by selecting **Share via tellAboutIt**.
