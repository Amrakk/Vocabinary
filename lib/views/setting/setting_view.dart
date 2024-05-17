import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabinary/models/data/user.dart';
import 'package:vocabinary/routes/routes.dart';
import 'package:vocabinary/services/firebase/authentication_service.dart';
import 'package:vocabinary/viewmodels/Setting/setting_view_model.dart';
import 'package:vocabinary/widgets/global/loading_indicator.dart';
import 'package:vocabinary/widgets/global/show_snack_bar.dart';

import '../../utils/app_colors.dart';
import '../../widgets/global/button.dart';
import '../../widgets/shimmer/input_loading.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  late UserModel user;
  late SettingViewModel? settingViewModel;
  bool isLoading = true;

  void init() async{
    settingViewModel = Provider.of<SettingViewModel>(context, listen: false);
    user = await settingViewModel?.getUser() ?? UserModel();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  @override
  Widget build(BuildContext context) {
    AppColorsThemeData myColors =
        Theme.of(context).extension<AppColorsThemeData>()!;
    return Padding(
        padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(children: [
              isLoading ?  const SizedBox(
                height: 140,
                width: 140,
                child: InputLoading(),
              )  : CircleAvatar(
                radius: 50,
                backgroundImage: user.avatar!.isEmpty ? const AssetImage('assets/images/avatar.jpg')
                    : Image.network(user.avatar!, fit: BoxFit.cover,).image,
              ),
              const SizedBox(height: 15),
               Text(
                isLoading ? "Loading" : user.name.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              // General
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: myColors.containerColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 15, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("General",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.person),
                                SizedBox(width: 10),
                                Text("My Account",
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed(AppRoutes.settingRoutes[1]);
                                },
                                icon: const Icon(Icons.arrow_forward_ios,
                                    size: 20)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(
                          color: Colors.white24,
                          endIndent: 10,
                          indent: 10,
                          height: 1,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.password),
                                SizedBox(width: 10),
                                Text("Change Password",
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed(AppRoutes.settingRoutes[2]);
                                },
                                icon: const Icon(Icons.arrow_forward_ios,
                                    size: 20)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(
                          color: Colors.white24,
                          endIndent: 10,
                          indent: 10,
                          height: 1,
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.language),
                                SizedBox(width: 10),
                                Text("Language",
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            Row(
                              children: [
                                Text("English", style: TextStyle(fontSize: 16)),
                                IconButton(
                                    onPressed: null,
                                    icon: Icon(Icons.arrow_forward_ios,
                                        size: 20)),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 25),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: myColors.containerColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 15, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Support",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.warning_outlined),
                                SizedBox(width: 10),
                                Text("Report an issue",
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context ,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text("Report an issue"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text("Please describe the issue you are facing"),
                                              const SizedBox(height: 10),
                                              const TextField(
                                                decoration: InputDecoration(
                                                  hintText: "Description",
                                                ),
                                                maxLines: 5,
                                              ),
                                              const SizedBox(height: 10),
                                              Button(
                                                nameButton: "Send",
                                                onPressed: () {
                                                  showLoadingIndicator(context);
                                                  Future.delayed(const Duration(seconds: 1), () {
                                                    closeLoadingIndicator(context);
                                                    ShowSnackBar.showSuccess("Issue reported successfully", context);
                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                              )
                                            ],
                                          ),
                                        );
                                      }
                                  );
                                },
                                icon: const Icon(Icons.arrow_forward_ios,
                                    size: 20)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(
                          color: Colors.white24,
                          endIndent: 10,
                          indent: 10,
                          height: 1,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.star),
                                SizedBox(width: 10),
                                Text("Rate App", style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text("Rate App"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text("Please rate app on the store"),
                                              const SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: List.generate(5, (index) =>
                                                  IconButton(
                                                      onPressed: () {
                                                        showLoadingIndicator(context);
                                                        Future.delayed(const Duration(seconds: 1), () {
                                                          closeLoadingIndicator(context);
                                                          ShowSnackBar.showSuccess("Rated ${index + 1 } stars", context);
                                                          Navigator.of(context).pop();
                                                        });
                                                      },
                                                      icon: const Icon(Icons.star, color: Colors.yellow, size: 30)),
                                                )
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                  );
                                },
                                icon: const Icon(Icons.arrow_forward_ios,
                                    size: 20)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(
                          color: Colors.white24,
                          endIndent: 10,
                          indent: 10,
                          height: 1,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.info),
                                SizedBox(width: 10),
                                Text("About", style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed(AppRoutes.settingRoutes[0]);
                                },
                                icon: const Icon(Icons.arrow_forward_ios,
                                    size: 20)),
                          ],
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 25),
              Button(
                nameButton: 'Log Out',
                onPressed: () {
                  AuthenticationService.instance.signOut();
                },
              ),
              const SizedBox(height: 40),
            ]),
          ),
        ));
  }
}
