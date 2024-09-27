import 'dart:io';

import 'package:cafeteria2/widgets/custom_text_field.dart';
import 'package:cafeteria2/widgets/error_dialog.dart';
import 'package:cafeteria2/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

XFile? imageXFile;
final ImagePicker _picker = ImagePicker();

Future<void> _getImage() async{
 imageXFile = await _picker.pickImage(source: ImageSource.gallery);
 setState(() {
   imageXFile;
 });
}

Future<void> formValidation() async
{
  if(imageXFile == null)
  {
    showDialog(
      context: context,
      builder: (c)
      {
        return ErrorDialog(
          message: "Please select an image.",
        );
      }
    );
  }
  else
  {
    if(passwordController.text == confirmPasswordController.text)
    {
      if (confirmPasswordController.text.isNotEmpty && emailController.text.isNotEmpty && nameController.text.isNotEmpty && phoneController.text.isNotEmpty)
      {
        //start uploading image
      }
      else
      {
        showDialog(
            context: context,
            builder: (c)
            {
              return LoadingDialog(
                message: "Please write the complete required info for Registraction.",
              );
            }
        );
      }
    }
    else
    {
      showDialog(
          context: context,
          builder: (c)
          {
            return ErrorDialog(
              message: "Password do not match.",
            );
          }
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children:[
         const SizedBox(height: 10,),

          InkWell(
            onTap: (){
              _getImage();
            },
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width*0.20,
              backgroundColor: Colors.white,
              backgroundImage: imageXFile == null? null: FileImage(File (imageXFile!.path)),
              child: imageXFile == null
                  ?
              Icon(
                Icons.add_photo_alternate,
                size: MediaQuery.of(context).size.width*0.20,
                color: Colors.grey,
              ): null,
            ),

            ),
          const SizedBox(height: 10,),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Customtextfield(
                  data: Icons.person,
                  controller: nameController,
                  hintText: "Name",
                  isObsecre: false,
                ),

                Customtextfield(
                  data: Icons.email,
                  controller: emailController,
                  hintText: "Email",
                  isObsecre: false,
                ),

                Customtextfield(
                  data: Icons.lock,
                  controller: passwordController,
                  hintText: "Password",
                  isObsecre: true,
                ),

                Customtextfield(
                  data: Icons.lock,
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  isObsecre: true,
                ),

                Customtextfield(
                  data: Icons.phone,
                  controller: phoneController,
                  hintText: "Phone",
                  isObsecre: false,
                ),

              ],
            ),
          ),

          const SizedBox(height: 30,),
          ElevatedButton(
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
            ),
            onPressed: ()
            {
              formValidation();
            }
          ),
          const SizedBox(height: 30,),
        ],
      )
    );
  }
}
