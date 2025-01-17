// import 'package:ClickEt/features/auth/presentation/view/login_view.dart';
// import 'package:ClickEt/features/auth/presentation/view/registration_view.dart';
// import 'package:ClickEt/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:ClickEt/features/auth/presentation/view_model/register/register_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class GetStartedCubit extends Cubit<void> {
//   final LoginBloc _loginBloc;
//   final RegisterBloc _registerBloc;

//   GetStartedCubit(this._loginBloc, this._registerBloc) : super(null);

//   void navigateToLogin(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BlocProvider.value(
//           value: _loginBloc,
//           child: const LoginView(),
//         ),
//       ),
//     );
//   }

//   void navigateToRegistration(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BlocProvider.value(
//           value: _registerBloc,
//           child: const RegistrationView(),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ClickEt/features/auth/presentation/view/login_view.dart';
import 'package:ClickEt/features/auth/presentation/view/registration_view.dart';

class GetStartedCubit extends Cubit<void> {
  GetStartedCubit() : super(null);

  void navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginView(),
      ),
    );
  }

  void navigateToRegistration(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegistrationView(),
      ),
    );
  }
}