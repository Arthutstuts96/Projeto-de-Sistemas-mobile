import 'package:flutter/material.dart';
import 'package:projeto_de_sistemas/controllers/login_controller.dart';
import 'package:projeto_de_sistemas/controllers/user_session_controller.dart';
import 'package:projeto_de_sistemas/domain/models/users/user.dart';
import 'package:projeto_de_sistemas/screens/components/profile/options_buttons.dart';
import 'package:projeto_de_sistemas/screens/components/button.dart';
import 'package:projeto_de_sistemas/screens/profile_screens/address_screen.dart';
import 'package:projeto_de_sistemas/screens/profile_screens/help_screen.dart';
import 'package:projeto_de_sistemas/screens/profile_screens/my_account_screen.dart';
import 'package:projeto_de_sistemas/utils/api_configs.dart';
import 'package:projeto_de_sistemas/utils/functions/validation_functions.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final verifiedAccount = true;

  final LoginController _loginController = LoginController();
  final UserController _userController = UserController();
  User? currentUser;

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  void _initUser() async {
    final user = await _userController.getCurrentUserFromSession();
    setState(() {
      currentUser = user;
    });
  }

  void _logout(BuildContext context) async {
    await _loginController.logout();
    Navigator.of(context).pushReplacementNamed('login_screen');
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirmar saída'),
            content: const Text('Tem certeza que deseja sair da conta?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              Button(
                onPressed: () {
                  Navigator.of(context).pop();
                  _logout(context);
                },
                color: Colors.red,
                text: 'Sair',
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 12,
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Usuário não encontrado: Por favor, tente entrar novamente",
              textAlign: TextAlign.center,
            ),
            OptionsButtons(
              text: "Sair",
              icon: Icons.logout,
              color: Colors.redAccent,
              onClick: () {
                _confirmLogout(context);
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 56),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentUser!.completeName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Cliente, entregador e separador",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        "Membro desde ${formatDate(currentUser!.dateJoined)}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder:
                          (context) => GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Dialog(
                              backgroundColor: Colors.transparent,
                              child: Center(
                                child: Container(
                                  width: 380,
                                  height: 380,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/choose_screen_background.jpg",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    );
                  },
                  child: const CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/choose_screen_background.jpg",
                    ),
                    minRadius: 50,
                    backgroundColor: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              children: [
                VerifyAccountBanner(currentUser: currentUser!),
                OptionsButtons(
                  text: "Minha conta",
                  icon: Icons.person,
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MyAccountScreen(
                            title: "Minha conta",
                            user: currentUser,
                          );
                        },
                      ),
                    );
                  },
                ),
                const Divider(),
                OptionsButtons(
                  text: "Entrar como entregador",
                  icon: Icons.delivery_dining,
                  onClick: () {
                    Navigator.pushNamed(context, 'delivery_screen');
                  },
                ),
                const Divider(),
                OptionsButtons(
                  text: "Entrar como separador",
                  icon: Icons.person_search_rounded,
                  onClick: () {
                    Navigator.pushNamed(context, 'main_shopper_screen');
                  },
                ),
                const Divider(),
                OptionsButtons(
                  text: "Endereços",
                  icon: Icons.house,
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AddressScreen(
                            title: "Endereços",
                            user: currentUser!,
                          );
                        },
                      ),
                    );
                  },
                ),
                const Divider(),
                // const OptionsButtons(
                //   text: "Meus cartões",
                //   icon: Icons.credit_score,
                // ),
                // const Divider(),
                OptionsButtons(
                  text: "Ajuda",
                  icon: Icons.help_outlined,
                  onClick: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const HelpScreen(title: "Ajuda");
                        },
                      ),
                    );
                  },
                ),
                const Divider(),
                OptionsButtons(
                  text: "Sair",
                  icon: Icons.logout,
                  color: Colors.redAccent,
                  onClick: () {
                    _confirmLogout(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VerifyAccountBanner extends StatefulWidget {
  final User currentUser;

  const VerifyAccountBanner({super.key, required this.currentUser});

  @override
  State<VerifyAccountBanner> createState() => _VerifyAccountBannerState();
}

class _VerifyAccountBannerState extends State<VerifyAccountBanner> {
  bool showBanner = true;

  @override
  Widget build(BuildContext context) {
    if (!showBanner) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 12, right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFD44F6E), Color(0xFFF0B5D3)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/girl/girl_verify_account.png",
                width: 80,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.currentUser.firstName},",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Deixe sua conta mais segura verificando ela por aqui.",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse(ipHost));
                      },
                      child: const Text(
                        "Verificar conta",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showBanner = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.3),
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(Icons.close, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
