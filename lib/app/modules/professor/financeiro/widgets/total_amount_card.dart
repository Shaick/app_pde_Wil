import 'package:app_pde/app/modules/professor/financeiro/financeiro_professor_store.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/widgets/custom_card.dart';
import 'package:app_pde/app/shared/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

class TotalAmountCard extends StatelessWidget {
  final String total;
  final String cardTitle;
  final bool showWithdrawButton;

  const TotalAmountCard({
    required this.total,
    required this.cardTitle,
    this.showWithdrawButton = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<FinanceiroProfessorStore>();
    return CustomCard(
      padding: const EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            cardTitle.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: AppColors.grey,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            total,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGrey,
            ),
          ),
          const SizedBox(height: 12),
          if (showWithdrawButton) ...[
            const SizedBox(height: 12),
            const CustomDivider(),
            _buildRequestWithdrawButton(context, controller)
          ]
        ],
      ),
    );
  }

  Widget _buildRequestWithdrawButton(
    BuildContext context,
    FinanceiroProfessorStore controller,
  ) {
    return TextButton.icon(
      icon: const Icon(Icons.paid, color: AppColors.accent),
      label: const Text(
        'SOLICITAR SAQUE',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.accent,
        ),
      ),
      onPressed: () async {
        final result = await showDialog<bool>(
          context: context,
          builder: (_) => _buildConfirmDialog(context, controller),
        );
        if (result == true) {
          controller.requestWithdraw().then((_) {
            if (!controller.hasError) {}
          });
        }
      },
      style: TextButton.styleFrom(primary: AppColors.accent),
    );
  }

  Widget _buildConfirmDialog(
    BuildContext context,
    FinanceiroProfessorStore controller,
  ) {
    final withdrawAmount = controller.calculateWithdrawAmount();
    final parsedAmount =
        NumberFormat.currency(symbol: 'R\$').format(withdrawAmount);
    return AlertDialog(
      title: const Text('Tem certeza?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (total != parsedAmount) ...[
            const Text(
              'Há consultas que ainda não estão no período de saque, pedimos que aguarde 15 dias após a conclusão delas.',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12)
          ],
          RichText(
            text: TextSpan(
              style: const TextStyle(color: AppColors.darkGrey),
              children: [
                const TextSpan(text: 'Deseja solicitar um saque de'),
                TextSpan(
                  text: ' $parsedAmount ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: 'para a sua conta?'),
              ],
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(
            'VOLTAR',
            style: TextStyle(color: AppColors.primary),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text(
            'SOLICITAR',
            style: TextStyle(color: AppColors.error),
          ),
        ),
      ],
    );
  }
}
