import 'package:flutter/material.dart';
import '../CategoryChoose.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'lib/assets/images/bg3.webp',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 0,
            right: -80,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              child: Image.asset(
                'lib/assets/images/image3.png',
                fit: BoxFit.fitHeight,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
              ),
            ),
          ),
          Positioned(
            bottom: 13,
            left: 13,
            child: SizedBox(
              height:60,
              width:180,
              child: ElevatedButton(
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>new CategoryChoice()));},
                child: Text('Start', style: TextStyle(
                  fontSize: 25,color: Colors.white
                ),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,//Color(0xFF064687),
                  foregroundColor: Colors.white54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
