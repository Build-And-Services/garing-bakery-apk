import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garing_bakery_apk/core/config/theme.dart';
import 'package:garing_bakery_apk/core/widgets/button_widget.dart';
import 'package:garing_bakery_apk/core/widgets/input_widget.dart';
import 'package:garing_bakery_apk/features/auth/data/service/token_service.dart';
import 'package:garing_bakery_apk/features/profile/presenter/provider/form_profile_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateProfilePage extends StatelessWidget {
  final String id;

  UpdateProfilePage({super.key, required this.id});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final product = context.watch<ProductProvider>();
    final profile = context.watch<FormProfileProvider>();
    final formProfile = context.watch<FormProfileProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyTheme.primary,
          ),
          onPressed: () {
            formProfile.clearController();
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Update Profile',
          style: TextStyle(color: MyTheme.primary, fontWeight: FontWeight.w700),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _imagePreview(formProfile, context),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    logoImage(formProfile),
                    sectionName(formProfile),
                    sectionEmail(formProfile),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              child: ButtonWidget(
                title: !profile.isLoading
                    ? Text(
                        "Update Profile",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                tap: () async {
                  if (_formKey.currentState!.validate()) {
                    profile.setLoading = true;
                    final image = formProfile.image;

                    if (image != null) {
                      profile.isProccess = true;

                      profile.profileUpdate(id).then((value) async => {
                            if (value.success)
                              {
                                {MyTheme.alertSucces(context, value.message)}
                              }
                            else
                              {
                                {MyTheme.alertError(context, value.message)}
                              }
                          });
                      profile.isProccess = false;
                    } else {
                      MyTheme.alertWarning(context, "Gambar belum dimasukan");
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  InputWidget sectionName(FormProfileProvider formProfile) {
    return InputWidget(
      label: "nama",
      controller: formProfile.name,
    );
  }

  InputWidget sectionEmail(FormProfileProvider formProfile) {
    return InputWidget(
      label: "Email",
      controller: formProfile.email,
    );
  }

  InkWell _imagePreview(FormProfileProvider formProfile, BuildContext context) {
    return InkWell(
      onTap: () => formProfile.getImage(ImageSource.gallery),
      child: Container(
        height: 100,
        width: 100,
        decoration: const BoxDecoration(
          color: Color.fromARGB(161, 121, 85, 72),
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
        child: formProfile.image == null
            ? const Icon(
                Icons.upload_file_outlined,
                size: 70,
                color: MyTheme.primary,
              )
            : Image.file(
                //to show image, you type like this.
                File(formProfile.image!.path),
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 300,
              ),
      ),
    );
  }

  Row logoImage(FormProfileProvider formProfile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => formProfile.getImage(ImageSource.camera),
          child: const Icon(
            Icons.photo_camera_outlined,
            size: 30,
            color: MyTheme.primary,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () => formProfile.getImage(ImageSource.gallery),
          child: const Icon(
            Icons.image_outlined,
            size: 30,
            color: MyTheme.primary,
          ),
        )
      ],
    );
  }
}
