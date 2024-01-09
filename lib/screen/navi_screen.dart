


import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_navi/kakao_flutter_sdk_navi.dart';

class NaviScreen extends StatefulWidget {
  const NaviScreen({Key? key}) : super(key: key);

  @override
  State<NaviScreen> createState() => _NaviScreenState();
}

class _NaviScreenState extends State<NaviScreen> {



  void init() async{
    bool result = await NaviApi.instance.isKakaoNaviInstalled();
    if (result) {
      print('카카오내비 앱으로 길안내 가능');
    } else {
      print('카카오내비 미설치');
      // 카카오내비 설치 페이지로 이동
      launchBrowserTab(Uri.parse(NaviApi.webNaviInstall));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    init();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('시니어 배달 앱 테스트'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          if (await NaviApi.instance.isKakaoNaviInstalled()) {
            // 카카오내비 앱으로 길 안내하기, WGS84 좌표계 사용
            await NaviApi.instance.shareDestination(
              destination:
              Location(name: '카카오 판교오피스', x: '127.108640', y: '37.402111'),
              // 경유지 추가
              viaList: [
                Location(name: '판교역 1번출구', x: '127.111492', y: '37.395225'),
              ],
              option: NaviOption(coordType: CoordType.wgs84)
            );
          } else {
            // 카카오내비 설치 페이지로 이동
            launchBrowserTab(Uri.parse(NaviApi.webNaviInstall));
          }

        },
        child: Icon(Icons.place_outlined),
      ),
    );
  }
}
