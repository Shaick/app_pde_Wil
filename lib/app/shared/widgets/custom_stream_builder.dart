import 'package:flutter/material.dart';

class CustomStreamBuilder<T> extends StatelessWidget {
  final Stream<T>? stream;
  final Widget Function(T data) onSuccess;
  final Widget Function()? onError;
  final Widget Function()? onLoading;
  final T? initialData;

  const CustomStreamBuilder({
    Key? key,
    required this.stream,
    required this.onSuccess,
    this.onError,
    this.onLoading,
    this.initialData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      initialData: initialData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return onLoading != null
              ? onLoading!()
              : const Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasError) {
            return onError != null
                ? onError!()
                : const Center(child: Text('Erro ao carregar mensagens'));
          } else {
            return onSuccess(snapshot.data!);
          }
        }
      },
    );
  }
}
