import 'package:flutter/material.dart';
import 'package:matrimony/utils/app_colors.dart';
import 'package:matrimony/utils/app_static_strings.dart';
import 'package:matrimony/view/screens/settings/delete/delete_account_repo/delete_account_repo.dart';
import 'package:matrimony/view/widget/button/button.dart';
import 'package:matrimony/view/widget/customText/custom_text.dart';
import 'package:matrimony/view/widget/custom_appbar/custom_appbar.dart';
import 'package:matrimony/view/widget/pop_up/all_pop_up.dart';
import 'package:matrimony/view/widget/text_editingField/textediting_field.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: const CustomAppBar(
            title: AppStaticStrings.deleteAccount,
          ),
          bottomNavigationBar: CustomButton(
            text: AppStaticStrings.continuee,
            left: 20,
            right: 20,
            bottom: 24,
            ontap: () {
              if (formKey.currentState!.validate()) {
                AllPopUp.showDialogWith2Button(
                    button1ontap: () {
                      DeleteAccountRepo.deleteAccountRepo(
                          passWord: passwordController.text);
                    },
                    button2ontap: () {},
                    context: context,
                    title: AppStaticStrings.youSureWantToDeleteProfile,
                    button1Title: AppStaticStrings.delete,
                    button2Title: AppStaticStrings.cancel);
              }
            },
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Text

                const CustomText(
                  maxLines: 2,
                  bottom: 16,
                  textAlign: TextAlign.left,
                  color: AppColors.black100,
                  text: AppStaticStrings.toDeleteYourAccountPlease,
                ),

                //Password Controller

                Form(
                  key: formKey,
                  child: CustomTextField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppStaticStrings.fieldCantBeEmpty;
                      } else {
                        return null;
                      }
                    },
                    textEditingController: passwordController,
                    readOnly: false,
                    hintText: AppStaticStrings.enterYourPass,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
