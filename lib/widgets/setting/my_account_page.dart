import 'dart:typed_data';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabinary//../utils/app_colors.dart';
import 'package:vocabinary/models/api_responses/imgbb_api_res.dart';
import 'package:vocabinary/models/data/user.dart';
import 'package:vocabinary/services/api/img_api.dart';
import 'package:vocabinary/services/firebase/authentication_service.dart';
import 'package:vocabinary/viewmodels/Setting/setting_view_model.dart';
import 'package:vocabinary/widgets/authenticate/input_text.dart';
import 'package:vocabinary/widgets/global/loading_indicator.dart';
import 'package:vocabinary/widgets/global/show_snack_bar.dart';
import 'package:vocabinary/widgets/shimmer/input_loading.dart';

import '../global/button.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  bool isLoading = true;
  late SettingViewModel _settingViewModel;
  late UserModel? user;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController uidController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isChange = false;
  Uint8List? imageUploaded;

  void init() async {
    _settingViewModel = Provider.of<SettingViewModel>(context, listen: false);
    user = await _settingViewModel.getUser();
    if (user != null) {
      nameController.text = user!.name ?? "";
      emailController.text = user!.email ?? "";
      uidController.text = AuthenticationService.instance.currentUser!.uid;
    }
    setState(() {
      isLoading = false;
    });
  }

  void changeCheck() {
    if (nameController.text != user!.name ||
        emailController.text != user!.email || imageUploaded != null) {
      setState(() {
        isChange = true;
      });
    } else {
      setState(() {
        isChange = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      init();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    uidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppColorsThemeData appColors =
        Theme.of(context).extension<AppColorsThemeData>()!;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Account',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 25, right: 25),
          child: Column(
            children: [
              Stack(
                children: [
                 isLoading ?  const SizedBox(
                    height: 140,
                    width: 140,
                    child: InputLoading(),
                 )  : CircleAvatar(
                   onBackgroundImageError: (exception, stackTrace) {
                     ShowSnackBar.showError('Image Error', context);
                     setState(() {
                        imageUploaded = null;
                        isChange = false;
                     });
                   },
                    radius: 70,
                    backgroundImage: imageUploaded == null
                        ? user!.avatar!.isNotEmpty ?
                    Image.network(user!.avatar!,
                      loadingBuilder:
                      (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return  const SizedBox(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }
                    )
                        .image :
                    Image.asset('images/avatar.jpg').image
                        : Image.memory(imageUploaded!, fit: BoxFit.cover).image,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: appColors.containerColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                            imageUploaded = await ImageService.pickImage();
                            changeCheck();
                        },
                        child: const Icon(
                          Icons.camera_alt,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Column(
                children: isLoading
                    ? [
                        const InputLoading(),
                        const SizedBox(height: 30),
                        const InputLoading(),
                        const SizedBox(height: 30),
                        const InputLoading(),
                      ]
                    : [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              InputTextAuth(
                                controller: nameController,
                                label: 'Name',
                                hintText: 'Name',
                                icon: Icons.person,
                                validator: (value) {
                                  changeCheck();
                                  if (value!.isEmpty) {
                                    return 'Name is required';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  changeCheck();
                                },
                              ),
                              const SizedBox(height: 30),
                              InputTextAuth(
                                controller: emailController,
                                label: 'Email',
                                hintText: 'Email',
                                icon: Icons.email,
                                validator: (value) {
                                  if (!EmailValidator.validate(value!)) {
                                    return 'Please enter a valid email';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  changeCheck();
                                },
                              ),
                              const SizedBox(height: 30),
                              InputTextAuth(
                                controller: uidController,
                                label: 'UID',
                                isEnable: false,
                                hintText: 'UID',
                                icon: Icons.numbers_rounded,
                                onChanged: (value) {
                                  changeCheck();
                                },
                              ),
                            ],
                          ),
                        )
                      ],
              ),
              const SizedBox(height: 40),
              Button(
                isLoading: isLoading ? true : !isChange,
                nameButton: 'Save',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    showLoadingIndicator(context);
                    isChange = false;
                    late final result;
                    if(imageUploaded != null){
                      result = await ImageService.uploadImage(imageUploaded!);
                      if(result == null){
                        ShowSnackBar.showError('Something went wrong', context);
                        return;
                      }
                    }
                    await _settingViewModel.updateUser(
                      user = UserModel(
                        avatar: imageUploaded != null ? (result as ImgbbResponse).image : user!.avatar,
                        name: nameController.text,
                        email: emailController.text,
                      ),
                    );
                    closeLoadingIndicator(context);
                    ShowSnackBar.showSuccess('Update success', context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
