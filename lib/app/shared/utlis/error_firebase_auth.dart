String? strError(String str) {
  String count = str;
  return mapError['${str.substring(1, count.indexOf(']'))}'];
}

Map<String, String> mapError = {
  'firebase_auth/app-deleted': 'O banco de dados não foi localizado.',
  'firebase_auth/expired-action-code': 'O código da ação o ou link expirou.',
  'firebase_auth/invalid-action-code':
      'O código da ação é inválido. Isso pode acontecer se o código estiver malformado ou já tiver sido usado.',
  'firebase_auth/user-disabled':
      'O usuário correspondente à credencial fornecida foi desativado.',
  'firebase_auth/user-not-found':
      'O usuário não correponde à nenhuma credencial.',
  'firebase_auth/weak-password': 'A senha é muito fraca.',
  'firebase_auth/email-already-in-use':
      'Já existi uma conta com o endereço de email fornecido.',
  'firebase_auth/invalid-email': 'O endereço de e-mail não é válido.',
  'firebase_auth/operation-not-allowed':
      'O tipo de conta correspondente à esta credencial, ainda não encontra-se ativada.',
  'firebase_auth/account-exists-with-different-credential':
      'E-mail já associado a outra conta.',
  'firebase_auth/auth-domain-config-required':
      'A configuração para autenticação não foi fornecida.',
  'firebase_auth/credential-already-in-use':
      'Já existe uma conta para esta credencial.',
  'firebase_auth/operation-not-supported-in-this-environment':
      'Esta operação não é suportada no ambiente que está sendo executada. Verifique se deve ser http ou https.',
  'firebase_auth/timeout':
      'Excedido o tempo de resposta. O domínio pode não estar autorizado para realizar operações.',
  'firebase_auth/missing-android-pkg-name':
      'Deve ser fornecido um nome de pacote para instalação do aplicativo Android.',
  'firebase_auth/missing-continue-uri':
      'A próxima URL deve ser fornecida na solicitação.',
  'firebase_auth/missing-ios-bundle-id':
      'Deve ser fornecido um nome de pacote para instalação do aplicativo iOS.',
  'firebase_auth/invalid-continue-uri':
      'A próxima URL fornecida na solicitação é inválida.',
  'firebase_auth/unauthorized-continue-uri':
      'O domínio da próxima URL não está na lista de autorizações.',
  'firebase_auth/invalid-dynamic-link-domain':
      'O domínio de link dinâmico fornecido, não está autorizado ou configurado no projeto atual.',
  'firebase_auth/argument-error':
      'Verifique a configuração de link para o aplicativo.',
  'firebase_auth/invalid-persistence-type':
      'O tipo especificado para a persistência dos dados é inválido.',
  'firebase_auth/unsupported-persistence-type':
      'O ambiente atual não suportar o tipo especificado para persistência dos dados.',
  'firebase_auth/invalid-credential':
      'A credencial expirou ou está mal formada.',
  'firebase_auth/wrong-password': 'Senha incorreta.',
  'firebase_auth/invalid-verification-code':
      'O código de verificação da credencial não é válido.',
  'firebase_auth/invalid-verification-id':
      'O ID de verificação da credencial não é válido.',
  'firebase_auth/custom-token-mismatch':
      'O token está diferente do padrão solicitado.',
  'firebase_auth/invalid-custom-token': 'O token fornecido não é válido.',
  'firebase_auth/captcha-check-failed':
      'O token de resposta do reCAPTCHA não é válido, expirou ou o domínio não é permitido.',
  'firebase_auth/invalid-phone-number':
      'O número de telefone está em um formato inválido (padrão E.164).',
  'firebase_auth/missing-phone-number': 'O número de telefone é requerido.',
  'firebase_auth/quota-exceeded': 'A cota de SMS foi excedida.',
  'firebase_auth/cancelled-popup-request':
      'Somente uma solicitação de janela pop-up é permitida de uma só vez.',
  'firebase_auth/popup-blocked':
      'A janela pop-up foi bloqueado pelo navegador.',
  'firebase_auth/popup-closed-by-user':
      'A janela pop-up foi fechada pelo usuário sem concluir o login no provedor.',
  'firebase_auth/unauthorized-domain':
      'O domínio do aplicativo não está autorizado para realizar operações.',
  'firebase_auth/invalid-user-token': 'O usuário atual não foi identificado.',
  'firebase_auth/user-token-expired': 'O token do usuário atual expirou.',
  'firebase_auth/null-user': 'O usuário atual é nulo.',
  'firebase_auth/app-not-authorized':
      'Aplicação não autorizada para autenticar com a chave informada.',
  'firebase_auth/invalid-api-key': 'A chave da API fornecida é inválida.',
  'firebase_auth/network-request-failed': 'Falha de conexão com a rede.',
  'firebase_auth/requires-recent-login':
      'O último horário de acesso do usuário não atende ao limite de segurança.',
  'firebase_auth/too-many-requests':
      'As solicitações foram bloqueadas devido a atividades incomuns. Tente novamente depois que algum tempo.',
  'firebase_auth/web-storage-unsupported':
      'O navegador não suporta armazenamento ou se o usuário desativou este recurso.',
  'firebase_auth/invalid-claims':
      'Os atributos de cadastro personalizado são inválidos.',
  'firebase_auth/claims-too-large':
      'O tamanho da requisição excede o tamanho máximo permitido de 1 Megabyte.',
  'firebase_auth/id-token-expired': 'O token informado expirou.',
  'firebase_auth/id-token-revoked': 'O token informado perdeu a validade.',
  'firebase_auth/invalid-argument':
      'Um argumento inválido foi fornecido a um método.',
  'firebase_auth/invalid-creation-time':
      'O horário da criação precisa ser uma data UTC válida.',
  'firebase_auth/invalid-disabled-field':
      'A propriedade para usuário desabilitado é inválida.',
  'firebase_auth/invalid-display-name': 'O nome do usuário é inválido.',
  'firebase_auth/invalid-email-verified': 'O e-mail é inválido.',
  'firebase_auth/invalid-hash-algorithm':
      'O algoritmo de HASH não é uma criptografia compatível.',
  'firebase_auth/invalid-hash-block-size':
      'O tamanho do bloco de HASH não é válido.',
  'firebase_auth/invalid-hash-derived-key-length':
      'O tamanho da chave derivada do HASH não é válido.',
  'firebase_auth/invalid-hash-key':
      'A chave de HASH precisa ter um buffer de byte válido.',
  'firebase_auth/invalid-hash-memory-cost':
      'O custo da memória HASH não é válido.',
  'firebase_auth/invalid-hash-parallelization':
      'O carregamento em paralelo do HASH não é válido.',
  'firebase_auth/invalid-hash-rounds': 'O arredondamento de HASH não é válido.',
  'firebase_auth/invalid-hash-salt-separator':
      'O campo do separador de SALT do algoritmo de geração de HASH precisa ser um buffer de byte válido.',
  'firebase_auth/invalid-id-token': 'O código do token informado não é válido.',
  'firebase_auth/invalid-last-sign-in-time':
      'O último horário de login precisa ser uma data UTC válida.',
  'firebase_auth/invalid-page-token':
      'A próxima URL fornecida na solicitação é inválida.',
  'firebase_auth/invalid-password':
      'A senha é inválida, precisa ter pelo menos 6 caracteres.',
  'firebase_auth/invalid-password-hash': 'O HASH da senha não é válida.',
  'firebase_auth/invalid-password-salt': 'O SALT da senha não é válido.',
  'firebase_auth/invalid-photo-url': 'A URL da foto de usuário é inválido.',
  'firebase_auth/invalid-provider-id':
      'O identificador de provedor não é compatível.',
  'firebase_auth/invalid-session-cookie-duration':
      'A duração do COOKIE da sessão precisa ser um número válido em milissegundos, entre 5 minutos e 2 semanas.',
  'firebase_auth/invalid-uid':
      'O identificador fornecido deve ter no máximo 128 caracteres.',
  'firebase_auth/invalid-user-import':
      'O registro do usuário a ser importado não é válido.',
  'firebase_auth/invalid-provider-data': 'O provedor de dados não é válido.',
  'firebase_auth/maximum-user-count-exceeded':
      'O número máximo permitido de usuários a serem importados foi excedido.',
  'firebase_auth/missing-hash-algorithm':
      'É necessário fornecer o algoritmo de geração de HASH e seus parâmetros para importar usuários.',
  'firebase_auth/missing-uid':
      'Um identificador é necessário para a operação atual.',
  'firebase_auth/reserved-claims':
      'Uma ou mais propriedades personalizadas fornecidas usaram palavras reservadas.',
  'firebase_auth/session-cookie-revoked':
      'O COOKIE da sessão perdeu a validade.',
  'firebase_auth/uid-alread-exists':
      'O indentificador fornecido já está em uso.',
  'firebase_auth/email-already-exists': 'O e-mail fornecido já está em uso.',
  'firebase_auth/phone-number-already-exists':
      'O telefone fornecido já está em uso.',
  'firebase_auth/project-not-found': 'Nenhum projeto foi encontrado.',
  'firebase_auth/insufficient-permission':
      'A credencial utilizada não tem permissão para acessar o recurso solicitado.',
  'firebase_auth/internal-error':
      'O servidor de autenticação encontrou um erro inesperado ao tentar processar a solicitação.',
};
