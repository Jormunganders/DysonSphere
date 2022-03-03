import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TallyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("TallyPage Build $hashCode");
    return Stack(
      children: <Widget>[
        // head background
        Container(
          color: Colors.blue,
        ),
        // 圆角矩形遮罩
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 490, // todo 换成 wrap_content
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    new BorderRadius.vertical(top: Radius.elliptical(44, 44)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    spreadRadius: 5.0,
                  )
                ]),
            child: Padding(
              padding: EdgeInsets.only(left: 44, right: 44),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '开始',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: TextField(
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: '用户名',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: TextField(
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: '邮箱',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: TextField(
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: '密码',
                      ),
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('注册',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 55,
                            height: 55,
                            child: ElevatedButton(
                              child: Icon(
                                Icons.chevron_right_outlined,
                                color: Colors.white,
                              ),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      CircleBorder())),
                              onPressed: () {},
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/**/
