# AutoPrintr-Mac

![logo](http://i.imgur.com/v7D7COV.png "AutoPrintr Logo")

Automatically print to the desired printer (instantly) - by http://www.repairshopr.com/

## Installation

Head to our [Help Page](http://feedback.repairshopr.com/knowledgebase/articles/944752-cloudprint-issues-meet-autoprintr) on AutoPrintr if you are an end user



Developers
-----------

1. Clone the AutoPrintr-mac repository  
2. Start XCode by clicking on AutoPrintr-mac.xcworkspace  
3. Create new Header File for Pusher credentials  
    3.1. For creating new file click on File > New File  
    3.2. Make sure you select OS X and then Header File  
    3.3. Name the file 'AppKeys'  
    3.4. A new header file should appear in your Project Navigator (AppKeys.h)  
    3.5. Add your Pusher Key in this header file  
            static NSString * const Pusher_KEY = @"YOUR_PUSHER_KEY";  
4. Run the project
