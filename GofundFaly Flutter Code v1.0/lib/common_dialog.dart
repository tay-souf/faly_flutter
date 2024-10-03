import 'package:flutter/material.dart';
import 'package:get/get.dart';



class DisclosureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prominent Disclosure'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Collection Disclosure'.tr,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'We collect your location data to provide better services. This data will be used to personalize your experience and provide location-based recommendations. We will not share your data with third parties without your consent.'.tr,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              'Please provide your consent to proceed.'.tr,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Record user consent and navigate to the main app
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainAppScreen()),
                    );
                  },
                  child: Text('Agree'.tr),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle user denial of consent
                    // Exit the app or restrict certain features
                  },
                  child: Text('Disagree'.tr),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MainAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main App'.tr),
      ),
      body: Center(
        child: Text('Welcome to the Main App'.tr),
      ),
    );
  }
}
