import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toktik/presentation/providers/discover_provider.dart';
import 'package:toktik/presentation/widgets/shared/video_scrollable_view.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final discoverProvider = context.watch<DiscoverProvider>();

    // si tenemos multiples providers
    //final otroProvider = Provider.of<DiscoverProvider>(context, listen: false); // hacer read

    return Scaffold(
      body: discoverProvider.initialLoading // si initial loading es verdadero mostramos el circularProgress
                                            // , de lo contrario el placeholder
      ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
      :  VideoScrollableView(videos: discoverProvider.videos)
    );
  }
}
