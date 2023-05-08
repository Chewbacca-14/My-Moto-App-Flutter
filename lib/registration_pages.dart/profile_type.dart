import '../helpers/colors_palette.dart';
import '../helpers/custom_button.dart';

import 'package:flutter/material.dart';

import '../helpers/fonts.dart';

class ProfileType extends StatefulWidget {
  const ProfileType({super.key});

  @override
  State<ProfileType> createState() => _ProfileTypeState();
}

class _ProfileTypeState extends State<ProfileType> {
  //is selected Пешеход container
  bool isSellectedFirst = true;
  //is selcted Автолюбитель container
  bool isSellectedSecond = false;
  @override
  Widget build(BuildContext context) {
    //screen width
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: width,
                height: 320,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/illustration4.png',
                      ),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  titleText(text: 'Тип профиля', bold: true, size: 32),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSellectedFirst = !isSellectedFirst;
                        isSellectedSecond = !isSellectedSecond;
                      });
                    },
                    child: Container(
                      width: width - 30,
                      height: 85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: isSellectedFirst
                              ? Border.all(color: MyColors.mainOrange, width: 1)
                              : Border.all(
                                  color:
                                      const Color.fromARGB(255, 216, 216, 216),
                                  width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mainText(
                                text: 'Пешеход',
                                bold: true,
                                size: 16,
                                color: Colors.black),
                            Spacer(),
                            isSellectedFirst
                                ? const Icon(
                                      Icons.check_circle_rounded,
                                    color: MyColors.mainOrange,
                                  )
                                : const Icon(
                                    Icons.circle_outlined,
                                    color: MyColors.mainGreySecond,
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSellectedFirst = !isSellectedFirst;
                        isSellectedSecond = !isSellectedSecond;
                      });
                    },
                    child: Container(
                      width: width - 30,
                      height: 85,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: isSellectedSecond
                              ? Border.all(color: MyColors.mainOrange, width: 1)
                              : Border.all(
                                  color:
                                      const Color.fromARGB(255, 216, 216, 216),
                                  width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mainText(
                                text: 'Автолюбитель',
                                bold: true,
                                size: 16,
                                color: Colors.black),
                            Spacer(),
                            isSellectedSecond
                                ? const Icon(
                                    Icons.check_circle_rounded,
                                    color: MyColors.mainOrange,
                                  )
                                : const Icon(
                                    Icons.circle_outlined,
                                    color: MyColors.mainGreySecond,
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 150),
            CustomButton(onTap: () {}, text: 'Регистрация')
          ],
        ),
      ),
    );
  }
}
