part of '../page.dart';

class CashierHomePage extends StatelessWidget {
  const CashierHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Stack(
      //   children: [
      //     Container(
      //       color: whiteColor,
      //       child: PageView.builder(
      //         controller: _pageController,
      //         onPageChanged: (value) {
      //           setState(() {
      //             _selectedIndex = value;
      //           });
      //         },
      //         itemCount: laundryWidget.length,
      //         itemBuilder: (BuildContext context, int index) => LayoutBuilder(
      //           builder: (context, constraints) {
      //             return SingleChildScrollView(
      //               child: ConstrainedBox(
      //                 constraints:
      //                     BoxConstraints(minHeight: constraints.maxHeight),
      //                 child: IntrinsicHeight(
      //                   child: Column(
      //                     children: [
      //                       LaundryHeader(laundry: widget.laundry),
      //                       Expanded(
      //                         child: Container(
      //                           padding: const EdgeInsets.all(defaultMargin),
      //                           decoration: BoxDecoration(
      //                             color: grayColor.withOpacity(0.1),
      //                             boxShadow: [
      //                               BoxShadow(
      //                                 color: Colors.black.withOpacity(0.05),
      //                                 offset: const Offset(0, -2),
      //                                 blurRadius: 24,
      //                                 spreadRadius: 2,
      //                               ),
      //                               BoxShadow(
      //                                 color: Colors.white.withOpacity(0.6),
      //                                 offset: const Offset(0, 2),
      //                                 blurRadius: 4,
      //                               ),
      //                             ],
      //                             borderRadius: const BorderRadius.only(
      //                               topLeft: Radius.circular(defaultMargin * 2),
      //                               topRight:
      //                                   Radius.circular(defaultMargin * 2),
      //                             ),
      //                           ),
      //                           child: Column(),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}