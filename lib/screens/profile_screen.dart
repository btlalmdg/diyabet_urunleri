import 'package:flutter/material.dart';
import '../data/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profile = ProfileController.instance;

  @override
  void initState() {
    super.initState();
    profile.addListener(_refresh);
  }

  @override
  void dispose() {
    profile.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() => setState(() {});

  Future<void> _showAccountForm({required bool register}) async {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(text: register ? '' : profile.name);
    final emailController = TextEditingController(text: register ? '' : profile.email);
    final passwordController = TextEditingController();

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            MediaQuery.of(sheetContext).viewInsets.bottom + 20,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    register ? 'Yeni Hesap Oluştur' : 'Giriş Yap',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (register) ...[
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Ad soyad',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.trim().isEmpty
                          ? 'Ad soyad girin'
                          : null,
                    ),
                    const SizedBox(height: 12),
                  ],
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-posta',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || !value.contains('@')
                        ? 'Geçerli bir e-posta girin'
                        : null,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Şifre',
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.length < 6
                        ? 'Şifre en az 6 karakter olmalı'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        profile.login(
                          name: register
                              ? nameController.text.trim()
                              : (profile.name ?? 'Diyabet Kullanıcısı'),
                          email: emailController.text.trim(),
                        );
                        Navigator.pop(sheetContext);
                        ScaffoldMessenger.of(this.context).showSnackBar(
                          SnackBar(
                            content: Text(
                              register
                                  ? 'Hesabınız oluşturuldu'
                                  : 'Giriş başarılı',
                            ),
                          ),
                        );
                      },
                      icon: Icon(register ? Icons.person_add : Icons.login),
                      label: Text(register ? 'Kayıt Ol' : 'Giriş Yap'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = profile.isLoggedIn;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profilim'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CircleAvatar(
            radius: 42,
            backgroundColor: Colors.blue[100],
            child: Icon(
              isLoggedIn ? Icons.person : Icons.person_outline,
              size: 48,
              color: Colors.blue[700],
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              isLoggedIn ? profile.name! : 'Misafir Kullanıcı',
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
          ),
          if (isLoggedIn) ...[
            const SizedBox(height: 4),
            Center(
              child: Text(
                profile.email!,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ],
          const SizedBox(height: 28),
          if (!isLoggedIn) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showAccountForm(register: false),
                icon: const Icon(Icons.login),
                label: const Text('Giriş Yap'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showAccountForm(register: true),
                icon: const Icon(Icons.person_add),
                label: const Text('Kayıt Ol'),
              ),
            ),
          ] else ...[
            Card(
              child: ListTile(
                leading: const Icon(Icons.shopping_bag_outlined),
                title: const Text('Siparişlerim'),
                subtitle: const Text('Sipariş geçmişinizi görüntüleyin'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sipariş geçmişi yakında')),
                  );
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Çıkış Yap'),
                onTap: profile.logout,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
