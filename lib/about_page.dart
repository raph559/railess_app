import 'package:flutter/material.dart';
import 'custom_colors.dart';

class AboutPage extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const AboutPage({super.key, required this.isDark, required this.onThemeChanged});

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.background,
      appBar: AppBar(
        backgroundColor: CustomColors.background,
        iconTheme: IconThemeData(
          color: widget.isDark ? Colors.black : Colors.white, // change your color here
        ),
        title: Text('About',
          style: TextStyle(
            fontSize: 30,
            color: (widget.isDark ? Colors.black : Colors.white),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Text(
              "Welcome to our corner of innovation! We are a dynamic team of six passionate students from Epitech, spanning across our first and second years of study. Driven by the ethos of exploration and creativity, we embarked on a journey to tackle the realm of Open Data.\n\n"
                  "With boundless enthusiasm, we delved into the vast landscape of possibilities and unanimously chose to explore the realm of Open Data. Among the myriad of options, we found ourselves drawn to the rich tapestry of information provided by the SNCF. Thus, our mission was born – to harness the power of Open Data to streamline access to essential railway information.\n\n"
                  "Through collaborative effort and tireless dedication, we crafted a digital platform empowered by the SNCF API. Our goal? To provide users with swift and seamless access to vital data pertaining to railway stations. Whether it's departure times, platform information, or service updates, our platform stands as a beacon of efficiency in the realm of transportation information.\n\n"
                  "Beyond the mere development of a website, our endeavor symbolizes a fusion of innovation and utility. It represents our collective commitment to leveraging technology for the betterment of society, making essential information accessible at the click of a button.\n\n"
                  "As we continue to navigate the ever-evolving landscape of technology and data, we invite you to join us on this exhilarating journey. Together, let's unlock the potential of Open Data and pave the way for a brighter, more connected future.\n\n",
              style: TextStyle( fontSize: 20.0, color: (widget.isDark ? Colors.black : Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}