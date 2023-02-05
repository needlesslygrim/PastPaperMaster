import 'package:flutter/material.dart';
import 'package:past_paper_master/components/button.dart';
import 'package:past_paper_master/core/colors.dart';
import 'package:past_paper_master/core/textstyle.dart';
import 'package:rive/rive.dart';
import 'package:provider/provider.dart';
import 'package:past_paper_master/core/provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.watch<CheckoutCN>().items.isEmpty
              ? 'Checkout'
              : "Checkout - ${context.watch<CheckoutCN>().items.length} item${context.read<CheckoutCN>().items.length == 1 ? '' : 's'}",
          style: MTextStyles.dsmMdGrey900,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            MButton(
              onPressed: () {
                if (context.read<CheckoutCN>().selected.length ==
                    context.read<CheckoutCN>().items.length) {
                  context.read<CheckoutCN>().selectNone();
                } else {
                  context.read<CheckoutCN>().selectAll();
                }
              },
              title: (context.watch<CheckoutCN>().selected.length ==
                      context.watch<CheckoutCN>().items.length)
                  ? "Select None"
                  : "Select All",
            ),
            const SizedBox(width: 8),
            MButton(
              onPressed: () {
                context.read<CheckoutCN>().deleteSelection();
              },
              title: "Delete Selection",
            ),
            const Spacer(),
            // MButton(
            //   onPressed: () {
            //     print("===");
            //     var items = context.read<CheckoutCN>().items;
            //     for (var i in items) {
            //       print("${i.name} -> ${i.path} @ ${i.hashCode}");
            //     }
            //   },
            //   title: "Print all",
            // ),
            // const SizedBox(width: 8),
            MButton(
              onPressed: () {
                if (context.read<DownloadCN>().downloadPath == '') {
                  // show alertdialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("No download path selected"),
                      content: const Text(
                          "Please select a download path in the settings page."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Dismiss"),
                        ),
                      ],
                    ),
                  );
                } else {
                  // context.read<DownloadCN>().downloadSelection();
                }
              },
              title: "Download Selection",
              primary: true,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
              color: MColors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: MColors.grey.shade200, width: 1),
              boxShadow: const [
                BoxShadow(
                    color: Color(0x19101828),
                    offset: Offset(0, 4),
                    blurRadius: 8,
                    spreadRadius: -2),
                BoxShadow(
                    color: Color(0x10101828),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                    spreadRadius: -2),
              ]),
          child: Column(
            children: [
              const CheckoutTableHeader(),
              if (context.watch<CheckoutCN>().items.isEmpty)
                const NoCheckoutPlaceholder(),
              for (var i = 0, l = context.watch<CheckoutCN>().items;
                  i < l.length;
                  i++) ...[
                CheckoutEntryRow(
                  item: l.elementAt(i),
                  documentType: "Document",
                  isSelected: context
                      .watch<CheckoutCN>()
                      .selected
                      .contains(l.elementAt(i)),
                  isLast: i == l.length - 1,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class CheckoutEntryRow extends StatelessWidget {
  const CheckoutEntryRow(
      {super.key,
      required this.item,
      required this.documentType,
      this.isLast = false,
      this.isSelected = false});
  final CheckoutItem item;
  final String documentType;
  final bool isLast;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: isLast
              ? const BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8))
              : BorderRadius.zero),
      onPressed: () {
        context.read<CheckoutCN>().toggleSelected(item);
      },
      fillColor: isSelected ? MColors.accent.shade50 : MColors.white,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: MColors.grey.shade200, width: 1),
          ),
        ),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  item.name,
                  style: isSelected
                      ? MTextStyles.smMdAccent700
                      : MTextStyles.smMdGrey900,
                )),
            Expanded(
                flex: 1,
                child: Text(
                  documentType,
                  style: MTextStyles.smRgGrey500,
                )),
            isSelected
                ? Icon(Icons.square_rounded,
                    color: MColors.accent.shade500, size: 16)
                : Icon(Icons.check_box_outline_blank,
                    color: MColors.grey.shade500, size: 16),
          ],
        ),
      ),
    );
  }
}

class CheckoutTableHeader extends StatelessWidget {
  const CheckoutTableHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MColors.grey.shade50,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Row(children: [
        Expanded(
            flex: 1,
            child: Text(
              'Document name',
              style: MTextStyles.xsMdGrey500,
            )),
        Expanded(
            flex: 1,
            child: Text(
              'Document type',
              style: MTextStyles.xsMdGrey500,
            )),
        const SizedBox(width: 16),
      ]),
    );
  }
}

class NoCheckoutPlaceholder extends StatelessWidget {
  const NoCheckoutPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: MColors.white,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
          border: Border.all(
              color: MColors.grey.shade200,
              width: 1,
              strokeAlign: StrokeAlign.outside),
        ),
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 64,
              height: 64,
              child: RiveAnimation.asset(
                'assets/rive/empty_folder.riv',
                artboard: 'empty checkout',
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(
              height: 8,
              width: double.infinity,
            ),
            Text(
              'Nothing to checkout',
              style: MTextStyles.mdMdGrey900,
            ),
            const SizedBox(
              height: 4,
              width: double.infinity,
            ),
            Text(
              'Seems like you haven\'t added any documents to checkout.',
              style: MTextStyles.smRgGrey500,
            ),
          ],
        ));
  }
}
