
import 'dart:io';

import 'package:apk_agenda_contatos/database/helper/contact_helper.dart';
import 'package:apk_agenda_contatos/database/model/contact_model.dart';
import 'package:apk_agenda_contatos/service/cep_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ContactPage extends StatefulWidget {
  final Contact? contact;

  const ContactPage({super.key, this.contact});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  Contact? _editContact;

  final phoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final cepMask = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final _cepController = TextEditingController();
  final _logradouroController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _estadoController = TextEditingController();
  final _numeroController = TextEditingController();
  final _complementoController = TextEditingController();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _consultandoCep = false;

  final ContactHelper _helper = ContactHelper();
  final ImagePicker _picker = ImagePicker();
  final CepService _cepService = CepService();

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _editContact = Contact(
        name: "",
        email: "",
        phone: "",
        img: null,
      );
    } else {
      _editContact = widget.contact;

      _nameController.text = _editContact?.name ?? '';
      _emailController.text = _editContact?.email ?? '';
      _phoneController.text = _editContact?.phone ?? '';
      _cepController.text = _editContact?.cep ?? '';
      _logradouroController.text = _editContact?.logradouro ?? '';
      _bairroController.text = _editContact?.bairro ?? '';
      _cidadeController.text = _editContact?.cidade ?? '';
      _estadoController.text = _editContact?.estado ?? '';
      _numeroController.text = _editContact?.numero ?? '';
      _complementoController.text = _editContact?.complemento ?? '';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(_editContact?.name ?? "Novo Contato"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveContact,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            GestureDetector(
              onTap: _selectImage,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _editContact?.img != null &&
                            _editContact!.img!.isNotEmpty
                        ? FileImage(File(_editContact!.img!))
                        : const AssetImage(
                            "assets/imgs/user_icon.png",
                          ) as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Nome",
              ),
              onChanged: (text) {
                setState(() {
                  _editContact?.name = text;
                });
              },
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (text) {
                _editContact?.email = text;
              },
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: "Telefone",
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [phoneMask],
              onChanged: (text) {
                _editContact?.phone = text;
              },
            ),

            const SizedBox(height: 20),

            // CEP COM PREENCHIMENTO AUTOMATICO
            TextField(
              controller: _cepController,
              keyboardType: TextInputType.number,
              inputFormatters: [cepMask],
              decoration: InputDecoration(
                labelText: "CEP",
                hintText: "00000-000",
                suffixIcon: _consultandoCep
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        ),
                      )
                    : IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: _consultarCep,
                      ),
              ),
              onChanged: (value) {
                final cep = value.replaceAll(
                  RegExp(r'\D'),
                  '',
                );

                if (cep.length == 8) {
                  _consultarCep();
                }
              },
            ),

            TextField(
              controller: _logradouroController,
              decoration: const InputDecoration(
                labelText: "Logradouro",
              ),
            ),

            TextField(
              controller: _bairroController,
              decoration: const InputDecoration(
                labelText: "Bairro",
              ),
            ),

            TextField(
              controller: _cidadeController,
              decoration: const InputDecoration(
                labelText: "Cidade",
              ),
            ),

            TextField(
              controller: _estadoController,
              decoration: const InputDecoration(
                labelText: "Estado/UF",
              ),
            ),

            TextField(
              controller: _numeroController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Número",
              ),
            ),

            TextField(
              controller: _complementoController,
              decoration: const InputDecoration(
                labelText: "Complemento",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Tirar foto"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Escolher da galeria"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
    );

    if (image != null && mounted) {
      setState(() {
        _editContact?.img = image.path;
      });
    }
  }

  Future<void> _consultarCep() async {
    if (_consultandoCep) return;

    final cep = _cepController.text.replaceAll(
      RegExp(r'\D'),
      '',
    );

    if (cep.length != 8) return;

    setState(() {
      _consultandoCep = true;
    });

    try {
      final endereco = await _cepService.buscaCEP(cep);

      if (!mounted) return;

      String obterCampo(List<String> nomes) {
        for (final nome in nomes) {
          final cep = endereco[nome];

          if (cep != null && cep.toString().trim().isNotEmpty) {
            return cep.toString();
          }
        }

        return '';
      }

      setState(() {
        _logradouroController.text = obterCampo([
          'street',
          'logradouro',
          'address',
        ]);

        _bairroController.text = obterCampo([
          'neighborhood',
          'bairro',
          'district',
        ]);

        _cidadeController.text = obterCampo([
          'city',
          'localidade',
          'cidade',
          'municipality',
        ]);

        _estadoController.text = obterCampo([
          'state',
          'uf',
          'estado',
        ]);
      });

      if (_logradouroController.text.isEmpty &&
          _bairroController.text.isEmpty &&
          _cidadeController.text.isEmpty &&
          _estadoController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'A API respondeu, mas não retornou os campos esperados.',
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao consultar CEP: $e'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _consultandoCep = false;
        });
      }
    }
  }

  
  Future<void> _saveContact() async {
    if (_editContact == null ||
        _editContact!.name.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nome é obrigatório'),
        ),
      );
      return;
    }

    if (!_validarEmail(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('E-mail inválido'),
        ),
      );
      return;
    }

    // Copia os dados atuais dos campos para o modelo.
    _editContact!
      ..name = _nameController.text.trim()
      ..email = _emailController.text.trim()
      ..phone = _phoneController.text.trim()
      ..cep = _cepController.text.trim()
      ..logradouro = _logradouroController.text.trim()
      ..bairro = _bairroController.text.trim()
      ..cidade = _cidadeController.text.trim()
      ..estado = _estadoController.text.trim()
      ..numero = _numeroController.text.trim()
      ..complemento = _complementoController.text.trim();

    if (_editContact!.id != null) {
      await _helper.updateContact(_editContact!);
    } else {
      await _helper.saveContact(_editContact!);
    }

    if (!mounted) return;

    Navigator.pop(context, _editContact);
  }


  bool _validarEmail(String email) {
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return regex.hasMatch(email.trim());
  }
}
