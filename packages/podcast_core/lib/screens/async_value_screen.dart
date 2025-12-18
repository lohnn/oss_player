import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/misc.dart';
import 'package:podcast_core/screens/error_screen.dart';
import 'package:podcast_core/screens/loading_screen.dart';

abstract class AsyncValueWidget<T> extends HookConsumerWidget {
  const AsyncValueWidget({super.key});

  ProviderBase<AsyncValue<T>> get provider;

  Widget buildWithData(BuildContext context, WidgetRef ref, T data);

  Widget? buildError(BuildContext context, WidgetRef ref, AsyncError<T> error) {
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(provider);

    // Check for custom error handling first, even if we have data
    if (asyncValue case AsyncError<T>()) {
      final customErrorWidget = buildError(context, ref, asyncValue);
      if (customErrorWidget != null) {
        return Material(child: customErrorWidget);
      }
    }

    return Material(
      child: switch (asyncValue) {
        AsyncValue<T>(value: final T data, hasValue: true) => buildWithData(
          context,
          ref,
          data,
        ),
        final AsyncError<T> state when !state.isLoading => ErrorScreen(
          state,
          onRefresh: () => ref.invalidate(provider),
        ),
        _ => const LoadingScreen(),
      },
    );
  }
}
