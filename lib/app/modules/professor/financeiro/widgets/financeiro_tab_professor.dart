import 'package:app_pde/app/modules/minhas_consultas_aluno/view_models/consulta_view_model.dart';
import 'package:app_pde/app/modules/professor/financeiro/widgets/total_amount_card.dart';
import 'package:app_pde/app/shared/utlis/app_colors.dart';
import 'package:app_pde/app/shared/widgets/custom_list_tile.dart';
import 'package:app_pde/app/shared/widgets/leading_rounded_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FinanceiroTabProfessor extends StatelessWidget {
  final List<ConsultaViewModel> consultas;
  final String cardTitle;
  final bool showWithdrawButton;

  const FinanceiroTabProfessor(
    this.consultas, {
    Key? key,
    this.cardTitle = 'TOTAL',
    this.showWithdrawButton = true,
  }) : super(key: key);

  String _calculateTotalReceived() {
    final totalAmount = consultas.fold<double>(0, (previousValue, element) {
      final parsedString = element.valor
          .replaceAll('R\$', '')
          .replaceAll('.', '')
          .replaceAll(',', '.')
          .trim();
      return previousValue + double.parse(parsedString);
    });
    return NumberFormat.currency(symbol: 'R\$').format(totalAmount);
  }

  @override
  Widget build(BuildContext context) {
    return consultas.isEmpty
        ? const Center(
            child: Text(
              'Nenhuma consulta para mostrar',
              style: const TextStyle(color: AppColors.grey),
            ),
          )
        : ListView.builder(
            itemCount: consultas.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 12),
                    TotalAmountCard(
                      total: _calculateTotalReceived(),
                      cardTitle: cardTitle,
                      showWithdrawButton: showWithdrawButton,
                    ),
                    const SizedBox(height: 24),
                  ],
                );
              } else {
                final consulta = consultas[index - 1];
                return CustomListTile(
                  icon: consulta.icon,
                  title: consulta.nomeMateria,
                  contentPadding: const EdgeInsets.symmetric(vertical: 6),
                  subtitle: 'Realizada em ${consulta.dataFim}',
                  leading: LeadingRoundedBox(
                    text: consulta.idNumerico,
                    color: AppColors.primary,
                  ),
                  trailing: Text(consulta.valor),
                );
              }
            },
          );
  }
}
