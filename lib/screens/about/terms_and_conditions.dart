import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

import 'package:url_launcher/url_launcher.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);
  static const String routeName = '/terms';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const TermsAndConditions(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('About DGW'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20, horizontal: 13.5),
                  child: Linkify(
                    onOpen: (link) async {
                      await launch(link.url);
                    },
                    text: aboutDGW,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

const String aboutDGW =
    '1.INTRODUCTION\n\nWelcome to the Discover Genius Within (DGW) App. This App is owned and operated by Discover Genius Within ( Parixit Khatri ).\n\nPLEASE READ THESE TERMS OF USE CAREFULLY BEFORE USING THE DGW APP.\n\nBy using this DGW App, you signify your agreement to these Terms of Use.  If you do not agree to these Terms of Use, you may not use the DGW App. In addition, when you use any of our current or future services, you will also be subject to our guidelines, terms, conditions, and agreements applicable to those services. If these Terms of Use are inconsistent with the guidelines, terms, and agreements applicable to those services, these Terms of Use will control.\n\n2.PRIVACY AND YOUR ACCOUNT\n\nPlease review our Privacy Policy, located at  HYPERLINK \n\nhttp://privacy-policy.discovergeniuswithin.com/ \n\nwhich also governs your visit to the DGW App, to understand our privacy practices.\n\nWe may sell products for children, but sell them to adults who can purchase with a credit card or other permitted payment method. If you are under 18, you may use the DGW App only with the involvement of a parent or guardian. We reserve the right to refuse service, terminate accounts, remove or edit content, or cancel orders at our sole discretion.\n\n3.CONSIDERATION\n\nYou agree that these Terms of Use are supported by reasonable and valuable consideration, the receipt and adequacy of which you hereby acknowledge, including, without limitation, your access to and use of the DGW App and data, materials, and information available at or through the DGW App.\n\n4.RESTRICTIONS ON USE; LIMITED LICENSE\n\nAll content contained on the DGW App (collectively, “Content“), such as text, graphics, logos, icons, images, audio and video clips, digital downloads, data compilations, and software, is our property or the property of our licensors or licensees, and the compilation of the Content on the DGW App is our exclusive property, protected by the United States and international copyright laws, treaties and conventions. All software used on the DGW App is our property or the property of our software suppliers and protected by the United States and international copyright laws, treaties, and conventions.\n\nAny trademarks, service marks, graphics, logos, page headers, icons, scripts, and trade names (each, a “Mark“) contained on the DGW App are proprietary to us or our licensors or licensees. Our Marks may not be used in connection with any product or service that is not ours in any manner that is likely to confuse users or that disparages or discredits us or anyone else. All other Marks not owned by us that appear on the DGW App are the property of their respective owners, who may or may not be affiliated with, connected to, or sponsored by us.\n\nWe grant you a limited license to access and make personal use of the DGW App. No Content of the DGW App or any other App or Internet site owned, operated, licensed, or controlled by us may be copied, reproduced, republished, downloaded (other than page caching), uploaded, posted, transmitted, or distributed in any way, or sold, resold, visited, or otherwise exploited for any commercial purpose, except that you may download one (1) copy of the Content that we make available to you for such purposes on a single device for your personal, noncommercial, home use only, provided that you: (a) keep intact all copyright, trademark and other proprietary rights notices; (b) do not modify any of the Content; (c) do not use any Content in a manner that suggests an association with any of our products, services or brands; and (d) do not download Content to avoid future downloads from the DGW App. Your use of Content on any other smartphone, tablet, website, or computer environment is strictly prohibited.\n\nThe license granted to you does not include, and specifically excludes, any rights to resell or make any commercial use of the DGW App or any Content; collect and use any product listings, descriptions, or prices; make any derivative use of the DGW App or Content; download or copy account information for the benefit of anyone else; or use any form of data mining, robots, or similar data gathering and extraction tools. You may not frame, or utilize framing techniques to enclose any Mark, Content, or other proprietary information, or use any meta tags or any other “hidden text” utilizing any such intellectual property, without our and each applicable owner’s express written consent. Any unauthorized use automatically terminates the license granted to you hereunder.\n\n5. USE AND PROTECTION OF PASSWORD AND ID\n\nYou may be assigned or be asked to create a password and account ID so you can access and use certain areas of the DGW App. Each user who uses such password and ID shall be deemed to be authorized by you to access and use the DGW App, and RRI shall have no obligation to investigate the authorization or source of any such access or use. YOU ACKNOWLEDGE AND AGREE THAT AS BETWEEN YOU AND RRI, YOU WILL BE SOLELY RESPONSIBLE FOR ALL ACCESS TO AND USE OF THE WEBSITE BY ANYONE USING YOUR PASSWORD AND ID  WHETHER OR NOT SUCH ACCESS TO AND USE OF THE DGW APP IS ACTUALLY AUTHORIZED BY YOU, INCLUDING ALL COMMUNICATIONS AND TRANSMISSIONS AND ALL OBLIGATIONS (INCLUDING FINANCIAL OBLIGATIONS FOR PURCHASES THROUGH THE DGW APP) THAT MAY RESULT FROM SUCH ACCESS OR USE.You are solely responsible for protecting the security and confidentiality of your password and ID. You shall immediately notify RRI or your app store provider of any unauthorized use of the password or ID, or any other breach or threatened breach of the DGW App’s security of which you are aware. You will be responsible for any activity conducted under your password or ID.\n\n6. SYSTEM REQUIREMENTS\nUse of the certain areas of the DGW App requires Internet or data access, audio manager software or other software allowing the downloading and storing of audio and audio-visual files in MP3 or other digital format (the “Software“), and, for certain downloadable content, a compatible player device (the “Device“). RRI may, at any time and from time to time, in its sole discretion, modify, revise, or otherwise change the system requirements for the DGW App and the format of any downloadable content, in whole or in part, without notice or liability to you.Internet or data access, use of the Software, or use of a Device may result in fees in addition to any fees incurred on the DGW App. Software and Devices may require you to obtain updates or upgrades from time to time. Your ability to use the DGW App may be affected by the performance of the Software, the Device, or your Internet/data connection. You acknowledge and agree that it is your sole responsibility to comply with the system requirements of your Software and Device, as in effect from time to time, and to maintain, update, and upgrade your Software and Devices, including the payment of all Internet/data access, Software, and Device fees without recourse to RRI.';
const TextStyle kHeading = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w600,
);
