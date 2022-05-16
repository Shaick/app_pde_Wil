class Constants {
  const Constants._();

  static final telefoneRegex = RegExp(r'(\(?\d{2}\)?\s)?(\d{4,5}\-\d{4})');
  static final badMessageRegex = RegExp(r'[0-9가-힣_]');
  static final numberRegex = RegExp(r'[0-9]');
  static final bankDataRegex = RegExp(r'[0-9-x]');
  static final cpfRegex = RegExp(r'^\d{3}\.\d{3}\.\d{3}\-\d{2}$');
  static final badFileRegex = RegExp(
      r'(bat|exe|cmd|sh|php([0-9])?|pl|cgi|386|dll|com|torrent|js|app|jar|pif|vb|vbscript|wsf|asp|cer|csr|jsp|drv|sys|ade|adp|bas|chm|cpl|crt|csh|fxp|hlp|hta|inf|ins|isp|jse|htaccess|htpasswd|ksh|lnk|mdb|mde|mdt|mdw|msc|msi|msp|mst|ops|pcd|prg|reg|scr|sct|shb|shs|url|vbe|vbs|wsc|wsf|wsh)');

  static const defaultPadding = 16.0;
  static const defaultBorderRadius = 20.0;
}
