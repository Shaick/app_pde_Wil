import 'package:app_pde/app/shared/utlis/constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

class Validators {
  // ignore: body_might_complete_normally_nullable
  static String? validarEmail(String input) {
    if (input.isEmpty) {
      return "Digite o seu email de login";
    } else if (!EmailValidator.validate(input.trim())) {
      return "Digite um email valido";
    }
  }

  // ignore: body_might_complete_normally_nullable
  static String? validarSenha(String input) {
    if (input.isEmpty || input.length == 0) {
      return "Digite sua senha";
    } else if (input.length < 6) {
      return "Sua senha deve conter no minimo 6 digitos";
    }
  }

  // ignore: body_might_complete_normally_nullable
  static String? validarTelefone(String input) {
    if (input.isEmpty) return 'Campo obrigatório';
    if (!Constants.telefoneRegex.hasMatch(input)) {
      return 'Telefone inválido';
    }
  }

  // ignore: body_might_complete_normally_nullable
  static String? validarConfirmaSenha(String firstInput, String secondInput) {
    if (firstInput != secondInput) return 'Senhas não conferem';
  }

  // ignore: body_might_complete_normally_nullable
  static String? validarApelido(String input) {
    if (Constants.numberRegex.hasMatch(input)) {
      return 'Campo inválido';
    }
  }

  // ignore: body_might_complete_normally_nullable
  static String? validarCpf(String input) {
    if (input.isEmpty) return 'Campo obrigatório';
    // if (!Constants.cpfRegex.hasMatch(input)) {
    // return 'CPF inválido';
    //}

    if (!CPFValidator.isValid(input)) {
      return "Cpf invalido";
    }
  }

  // ignore: body_might_complete_normally_nullable
  static String? validarBanco(String input) {
    if (Constants.numberRegex.hasMatch(input)) {
      return 'Banco inválido';
    }
  }

  // ignore: body_might_complete_normally_nullable
  static String? validarAgencia(String input) {
    if (!Constants.bankDataRegex.hasMatch(input) && input.isNotEmpty) {
      return 'Agência inválida';
    }
  }

  // ignore: body_might_complete_normally_nullable
  static String? validarConta(String input) {
    if (!Constants.bankDataRegex.hasMatch(input) && input.isNotEmpty) {
      return 'Conta inválida';
    }
  }

  // ignore: body_might_complete_normally_nullable
  static String? validarResetEmail(String input) {
    if (input.isEmpty) {
      return "Digite seu e-mail";
    }
  }

  // ignore: body_might_complete_normally_nullable
  static String? validarDataConsulta(String texto) {
    if (texto.isEmpty) {
      return "Data obrigatória";
    }
  }

  // ignore: body_might_complete_normally_nullable
  static String? validarHoraInicio(String texto) {
    if (texto.isEmpty) {
      return "Necessário adicionar horário de início";
    }
  }

  // ignore: body_might_complete_normally_nullable
  static String? validarHoraFinal(String texto) {
    if (texto.isEmpty) {
      return "Necessário adicionar horário final";
    }
  }

  // ignore: body_might_complete_normally_nullable
  static String? validarObs(String texto) {
    if (texto.isEmpty) {
      return "As observações são obrigatórias.";
    }
  }

  // ignore: body_might_complete_normally_nullable
  static String? validarReply(String texto) {
    if (texto.isEmpty) {
      return "Digite o texto para enviar.";
    }
  }

  // ignore: body_might_complete_normally_nullable
  static String? validaSoftwareResposta(String texto) {
    if (texto.isEmpty) {
      return "Você optou por um software de resolução";
    }
  }
}
