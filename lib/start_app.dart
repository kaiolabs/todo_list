import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list/src/core/presenters/shared/alert_dialog_pattern.dart';
import 'package:todo_list/src/core/presenters/shared/button_pattern.dart';
import 'package:todo_list/src/core/presenters/shared/input_field.dart';
import 'package:todo_list/src/core/presenters/shared/snack_bar_messenger.dart';
import 'package:todo_list/src/core/presenters/terms/terms_of_use.dart';
import 'package:todo_list/src/core/presenters/theme/color_outlet.dart';
import 'package:todo_list/src/core/presenters/theme/font_family_outlet.dart';
import 'package:todo_list/src/core/presenters/theme/size_outlet.dart';
import 'package:todo_list/src/core/repositories/db.dart';

class StartApp extends StatefulWidget {
  const StartApp({super.key});

  @override
  State<StartApp> createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerName = TextEditingController();
  bool terms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: SizeOutlet.paddingSizeDefault,
          left: SizeOutlet.paddingSizeDefault,
          right: SizeOutlet.paddingSizeDefault,
        ),
        child: ButtonPattern(
          label: 'Começar',
          onPressed: () async {
            if (_formKey.currentState!.validate() && terms) {
              await DB.setTermsAndUsername(terms, _controllerName.text);
              await DB.setLogged(true);
              Modular.to.navigate('/base/');
            } else {
              snackBarMessenger(
                context: context,
                message: 'Para ter acesso ao aplicativo, é necessário aceitar os termos de uso',
                duration: 2,
                color: ColorOutlet.colorPrimaryLight,
              );
            }
          },
        ),
      ),
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(
              left: SizeOutlet.paddingSizeMedium,
              right: SizeOutlet.paddingSizeMedium,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                      child: const Text('Minhas tarefas',
                          style: TextStyle(
                            fontSize: SizeOutlet.textSizeDefault,
                            fontFamily: FontFamilyOutlet.defaultFontFamilyRegular,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05,
                        bottom: MediaQuery.of(context).size.height * 0.03,
                      ),
                      child: SvgPicture.asset(
                        'assets/images/startPage.svg',
                        width: 200,
                      ),
                    ),
                    InputField(
                      controller: _controllerName,
                      label: 'Nome',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            activeColor: ColorOutlet.colorPrimary,
                            // checkColor: Configs.secondaryColor,
                            value: terms,
                            onChanged: (value) {
                              setState(() {
                                terms = value!;
                              });
                            },
                          ),
                          const Text(
                            'Eu aceito os termos de uso ',
                            style: TextStyle(
                              fontFamily: FontFamilyOutlet.defaultFontFamilyRegular,
                            ),
                          ),
                          InkWell(
                            child: const Text(
                              ' Termos de Uso',
                              style: TextStyle(
                                fontFamily: FontFamilyOutlet.defaultFontFamilyMedium,
                                color: ColorOutlet.colorPrimaryLight,
                              ),
                            ),
                            onTap: () {
                              alertDialogPattern(
                                context,
                                'Minhas tarefas',
                                TermsOfUse.termsOfUse,
                                confirmMode: true,
                                markdownMode: true,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
