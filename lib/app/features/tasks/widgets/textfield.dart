import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_test/app/_shared/settings/cubit/settings_cubit.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.formControlName,
    required this.hintText,
    this.validators = const [],
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    this.filled = false,
    this.fillColor,
    this.suffixIcon,
    this.validationMessages,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
  });

  final String formControlName;
  final TextInputType textInputType;
  final List<Validators> validators;
  final Widget? suffixIcon;
  final Map<String, String Function(Object)>? validationMessages;
  final bool obscureText;
  final bool readOnly;
  final bool filled;
  final Color? fillColor;
  final String hintText;
  final Function(String?)? onChanged;
  final Function? onSubmitted;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    final formGroup = ReactiveForm.of(context) as FormGroup;
    final control = formGroup.control(formControlName);

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: state.cache.isDarkMode
                    ? Theme.of(context).colorScheme.onSecondary
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: control.invalid
                      ? Theme.of(context).colorScheme.error
                      : Colors.black,
                ),
              ),
              child: Center(
                child: ReactiveTextField(
                  onTap: (control) {
                    if (onTap != null) {
                      onTap!();
                    }
                  },
                  readOnly: readOnly,
                  obscuringCharacter: '*',
                  formControlName: formControlName,
                  obscureText: obscureText,
                  keyboardType: textInputType,
                  textInputAction: TextInputAction.next,
                  showErrors: (control) => false,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    counterText: '',
                    isDense: true,
                    contentPadding: const EdgeInsets.only(
                      left: 16,
                    ),
                    border: InputBorder.none,
                    suffix: suffixIcon,
                  ),
                  onTapOutside: (_) {
                    control.markAsDirty();
                    FocusScope.of(context).unfocus();
                  },
                  onChanged: (control) {
                    control.markAsDirty();
                    if (onChanged != null) {
                      onChanged!(control.value as String?);
                    }
                  },
                  onSubmitted: (_) => onSubmitted?.call(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
            Container(
              height: 3,
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: control.invalid
                    ? Theme.of(context).colorScheme.error
                    : Colors.black,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(200),
                  bottomRight: Radius.circular(200),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
