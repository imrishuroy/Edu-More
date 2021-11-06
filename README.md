# edu_more

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


➜  edu_more cd ios
➜  ios pod update
Update all pods
Updating local specs repositories

CocoaPods 1.11.2 is available.
To update use: `sudo gem install cocoapods`

For more information, see https://blog.cocoapods.org and the CHANGELOG for this version at https://github.com/CocoaPods/CocoaPods/releases/tag/1.11.2

Analyzing dependencies
cloud_firestore: Using Firebase SDK version '8.8.0' defined in 'firebase_core'
cloud_functions: Using Firebase SDK version '8.8.0' defined in 'firebase_core'
firebase_auth: Using Firebase SDK version '8.8.0' defined in 'firebase_core'
firebase_core: Using Firebase SDK version '8.8.0' defined in 'firebase_core'
Downloading dependencies
Generating Pods project
Integrating client project
Pod installation complete! There are 17 dependencies from the Podfile and 38 total pods installed.

[!] Automatically assigning platform `iOS` with version `12.0` on target `Runner` because no platform was specified. Please specify a platform for this target in your Podfile. See `https://guides.cocoapods.org/syntax/podfile.html#platform`.

[!] CocoaPods did not set the base configuration of your project because your project already has a custom config set. In order for CocoaPods integration to work at all, please either set the base configurations of the target `Runner` to `Target Support Files/Pods-Runner/Pods-Runner.profile.xcconfig` or include the `Target Support Files/Pods-Runner/Pods-Runner.profile.xcconfig` in your build configuration (`Flutter/Release.xcconfig`).
➜  ios pod install
Analyzing dependencies
cloud_firestore: Using Firebase SDK version '8.8.0' defined in 'firebase_core'
cloud_functions: Using Firebase SDK version '8.8.0' defined in 'firebase_core'
firebase_auth: Using Firebase SDK version '8.8.0' defined in 'firebase_core'
firebase_core: Using Firebase SDK version '8.8.0' defined in 'firebase_core'
Downloading dependencies
Generating Pods project
Integrating client project
Pod installation complete! There are 17 dependencies from the Podfile and 38 total pods installed.

[!] Automatically assigning platform `iOS` with version `12.0` on target `Runner` because no platform was specified. Please specify a platform for this target in your Podfile. See `https://guides.cocoapods.org/syntax/podfile.html#platform`.

[!] CocoaPods did not set the base configuration of your project because your project already has a custom config set. In order for CocoaPods integration to work at all, please either set the base configurations of the target `Runner` to `Target Support Files/Pods-Runner/Pods-Runner.profile.xcconfig` or include the `Target Support Files/Pods-Runner/Pods-Runner.profile.xcconfig` in your build configuration (`Flutter/Release.xcconfig`).
➜  ios cd .. 
➜  edu_more flutter pub get
Running "flutter pub get" in edu_more...                         2,299ms
The plugins `apple_sign_in, stripe_payment` use a deprecated version of the Android embedding.
To avoid unexpected runtime failures, or future build failures, try to see if these plugins support the Android V2
embedding. Otherwise, consider removing them since a future release of Flutter will remove these deprecated APIs.
If you are plugin author, take a look at the docs for migrating the plugin to the V2 embedding:
https://flutter.dev/go/android-plugin-migration.
➜  edu_more flutter run 
The plugins `apple_sign_in, stripe_payment` use a deprecated version of the Android embedding.
To avoid unexpected runtime failures, or future build failures, try to see if these plugins support the Android V2
embedding. Otherwise, consider removing them since a future release of Flutter will remove these deprecated APIs.
If you are plugin author, take a look at the docs for migrating the plugin to the V2 embedding:
https://flutter.dev/go/android-plugin-migration.
Launching lib/main.dart on iPhone 11 in debug mode...
Running pod install...                                             22.7s
Running Xcode build...                                                  
Xcode build done.                                           124.7s
Failed to build iOS app
Error output from Xcode build:
↳
    --- xcodebuild: WARNING: Using the first of multiple matching destinations:
    { platform:iOS Simulator, id:dvtdevice-DVTiOSDeviceSimulatorPlaceholder-iphonesimulator:placeholder, name:Any iOS
    Simulator Device }
    { platform:iOS Simulator, id:B205072F-8796-4131-83F4-995EC2050333, OS:15.0, name:iPad (9th generation) }
    { platform:iOS Simulator, id:6B3F3211-1A83-410D-8091-8109FF4636C0, OS:15.0, name:iPad Air (4th generation) }
    { platform:iOS Simulator, id:F38AF5E7-49B3-4CB3-AD14-156D9A0D702A, OS:15.0, name:iPad Pro (9.7-inch) }
    { platform:iOS Simulator, id:869D08D2-E22E-4D00-A769-6BAC21925999, OS:15.0, name:iPad Pro (11-inch) (3rd
    generation) }
    { platform:iOS Simulator, id:791BC77D-8D45-4385-9087-050E1E26195D, OS:15.0, name:iPad Pro (12.9-inch) (5th
    generation) }
    { platform:iOS Simulator, id:0C419CB9-2B50-4BB1-BCB6-040D41427D4F, OS:15.0, name:iPad mini (6th generation) }
    { platform:iOS Simulator, id:4576A086-B109-4051-BE36-758CC44CEDA4, OS:15.0, name:iPhone 8 }
    { platform:iOS Simulator, id:D0F462E2-D8C3-4BAA-B9A5-5AAA1A74F2FB, OS:15.0, name:iPhone 8 Plus }
    { platform:iOS Simulator, id:D796388F-A900-400D-8D6D-2A9C8D7F96D8, OS:15.0, name:iPhone 11 }
    { platform:iOS Simulator, id:1A26265A-E635-4026-A3FC-D84E003522DC, OS:15.0, name:iPhone 11 Pro }
    { platform:iOS Simulator, id:03F1509F-D75D-4177-AB63-EF02FEF3D036, OS:15.0, name:iPhone 11 Pro Max }
    { platform:iOS Simulator, id:2538F3FE-05D0-4FF7-B148-19A731F106B7, OS:15.0, name:iPhone 12 }
    { platform:iOS Simulator, id:13F1E735-B9EA-4C50-AF59-0FF202E892A3, OS:15.0, name:iPhone 12 Pro }
    { platform:iOS Simulator, id:45B1476D-223E-40D7-922A-5E127D418130, OS:15.0, name:iPhone 12 Pro Max }
    { platform:iOS Simulator, id:BB4EA481-0225-4DA6-B5F7-3DA98FA04DA9, OS:15.0, name:iPhone 12 mini }
    { platform:iOS Simulator, id:82DB85F6-F633-4024-8D87-F6F71BEBB6FD, OS:15.0, name:iPhone 13 }
    { platform:iOS Simulator, id:93F66C71-AE9B-4371-B22F-0CBD78EC0018, OS:15.0, name:iPhone 13 Pro }
    { platform:iOS Simulator, id:50491212-DC1B-48FB-B494-A1E95C8D4DA4, OS:15.0, name:iPhone 13 Pro Max }
    { platform:iOS Simulator, id:6672BAB8-83BD-4530-8F8A-FCFF441F8084, OS:15.0, name:iPhone 13 mini }
    { platform:iOS Simulator, id:063A2B6A-A799-452C-AB03-62D2DA2BA634, OS:15.0, name:iPhone SE (2nd generation) }
    { platform:iOS Simulator, id:606C31DC-8500-4340-8E53-C6899E2F2589, OS:15.0, name:iPod touch (7th generation) }
    { platform:iOS, id:dvtdevice-DVTiPhonePlaceholder-iphoneos:placeholder, name:Any iOS Device }
    ** BUILD FAILED **


Xcode's output:
↳
    ld: warning: ignoring file /Users/imrishuroy/Desktop/Flutter
    Dev/edu_more/build/ios/Debug-iphonesimulator/Stripe/Stripe.framework/Stripe, missing required architecture arm64 in
    file /Users/imrishuroy/Desktop/Flutter Dev/edu_more/build/ios/Debug-iphonesimulator/Stripe/Stripe.framework/Stripe
    (2 slices)
    Undefined symbols for architecture arm64:
      "_OBJC_CLASS_$_STPAPIClient", referenced from:
          objc-class-ref in TPSStripeManager.o
      "_OBJC_CLASS_$_STPSetupIntentConfirmParams", referenced from:
          objc-class-ref in TPSStripeManager.o
      "_OBJC_CLASS_$_STPAppInfo", referenced from:
          objc-class-ref in TPSStripeManager.o
      "_OBJC_CLASS_$_STPPaymentIntentParams", referenced from:
          objc-class-ref in TPSStripeManager.o
      "_OBJC_CLASS_$_STPPaymentMethodParams", referenced from:
          objc-class-ref in TPSStripeManager.o
      "_OBJC_CLASS_$_STPTheme", referenced from:
          objc-class-ref in TPSStripeManager.o
      "_OBJC_CLASS_$_STPPaymentMethodBillingDetails", referenced from:
          objc-class-ref in TPSStripeManager.o
      "_OBJC_CLASS_$_STPPaymentMethodAddress", referenced from:
          objc-class-ref in TPSStripeManager.o
      "_OBJC_CLASS_$_STPCardParams", referenced from:
          objc-class-ref in TPSStripeManager.o
      "_OBJC_CLASS_$_STPAddCardViewController", referenced from:
          objc-class-ref in TPSStripeManager.o
      "_OBJC_CLASS_$_STPAddress", referenced from:
          objc-class-ref in TPSStripeManager.o
      "_STPStringFromCardBrand", referenced from:
          -[StripeModule cardBrandAsPresentableBrandString:] in TPSStripeManager.o
      "_OBJC_CLASS_$_STPPaymentHandler", referenced from:
          objc-class-ref in TPSStripeManager.o
      "_OBJC_CLASS_$_STPBankAccountParams", referenced from:
          objc-class-ref in TPSStripeManager.o
      "_OBJC_CLASS_$_STPPaymentConfiguration", referenced from:
          objc-class-ref in TPSStripeManager.o
      "_OBJC_CLASS_$_Stripe", referenced from:
          objc-class-ref in TPSStripeManager.o
         (maybe you meant: _OBJC_CLASS_$_StripePaymentPlugin, _OBJC_CLASS_$_StripeModule )
      "_OBJC_CLASS_$_STPPaymentMethodCardParams", referenced from:
          objc-class-ref in TPSStripeManager.o
      "_OBJC_CLASS_$_STPUserInformation", referenced from:
          objc-class-ref in TPSStripeManager.o
      "_OBJC_CLASS_$_STPRedirectContext", referenced from:
          objc-class-ref in TPSStripeManager.o
      "_OBJC_CLASS_$_STPSourceParams", referenced from:
          objc-class-ref in TPSStripeManager.o
    ld: symbol(s) not found for architecture arm64
    clang: error: linker command failed with exit code 1 (use -v to see invocation)
    note: Using new build system
    note: Planning
    note: Build preparation complete
    note: Building targets in parallel
    /Users/imrishuroy/Desktop/Flutter Dev/edu_more/ios/Pods/Pods.xcodeproj: warning: The iOS Simulator deployment
    target 'IPHONEOS_DEPLOYMENT_TARGET' is set to 8.0, but the range of supported deployment target versions is 9.0 to
    15.0.99. (in target 'leveldb-library' from project 'Pods')
    /Users/imrishuroy/Desktop/Flutter Dev/edu_more/ios/Pods/Pods.xcodeproj: warning: The iOS Simulator deployment
    target 'IPHONEOS_DEPLOYMENT_TARGET' is set to 8.0, but the range of supported deployment target versions is 9.0 to
    15.0.99. (in target 'abseil' from project 'Pods')
    /Users/imrishuroy/Desktop/Flutter Dev/edu_more/ios/Pods/Pods.xcodeproj: warning: The iOS Simulator deployment
    target 'IPHONEOS_DEPLOYMENT_TARGET' is set to 8.0, but the range of supported deployment target versions is 9.0 to
    15.0.99. (in target 'gRPC-C++-gRPCCertificates-Cpp' from project 'Pods')
    /Users/imrishuroy/Desktop/Flutter Dev/edu_more/ios/Pods/Pods.xcodeproj: warning: The iOS Simulator deployment
    target 'IPHONEOS_DEPLOYMENT_TARGET' is set to 8.0, but the range of supported deployment target versions is 9.0 to
    15.0.99. (in target 'FMDB' from project 'Pods')
    /Users/imrishuroy/Desktop/Flutter Dev/edu_more/ios/Pods/Pods.xcodeproj: warning: The iOS Simulator deployment
    target 'IPHONEOS_DEPLOYMENT_TARGET' is set to 8.0, but the range of supported deployment target versions is 9.0 to
    15.0.99. (in target 'BoringSSL-GRPC' from project 'Pods')
    /Users/imrishuroy/Desktop/Flutter Dev/edu_more/ios/Pods/Pods.xcodeproj: warning: The iOS Simulator deployment
    target 'IPHONEOS_DEPLOYMENT_TARGET' is set to 8.0, but the range of supported deployment target versions is 9.0 to
    15.0.99. (in target 'AppAuth' from project 'Pods')
    /Users/imrishuroy/Desktop/Flutter Dev/edu_more/ios/Pods/Pods.xcodeproj: warning: The iOS Simulator deployment
    target 'IPHONEOS_DEPLOYMENT_TARGET' is set to 8.0, but the range of supported deployment target versions is 9.0 to
    15.0.99. (in target 'gRPC-C++' from project 'Pods')
    /Users/imrishuroy/Desktop/Flutter Dev/edu_more/ios/Pods/Pods.xcodeproj: warning: The iOS Simulator deployment
    target 'IPHONEOS_DEPLOYMENT_TARGET' is set to 8.0, but the range of supported deployment target versions is 9.0 to
    15.0.99. (in target 'gRPC-Core' from project 'Pods')
    /Users/imrishuroy/Desktop/Flutter Dev/edu_more/ios/Pods/Pods.xcodeproj: warning: The iOS Simulator deployment
    target 'IPHONEOS_DEPLOYMENT_TARGET' is set to 8.0, but the range of supported deployment target versions is 9.0 to
    15.0.99. (in target 'GoogleSignIn' from project 'Pods')

Could not build the application for the simulator.
Error launching application on iPhone 11.
➜  edu_more 