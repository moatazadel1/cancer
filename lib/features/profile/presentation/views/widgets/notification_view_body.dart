import 'package:breast_cancer/features/profile/presentation/views/widgets/custom_notification_tile.dart';
import 'package:breast_cancer/generated/l10n.dart';
import 'package:flutter/material.dart';

class NotificationViewBody extends StatefulWidget {
  const NotificationViewBody({super.key});

  @override
  State<NotificationViewBody> createState() => _NotificationViewBodyState();
}

class _NotificationViewBodyState extends State<NotificationViewBody>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          S.of(context).Notifications,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 57,
            ),
            Text(
              S.of(context).Common,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 0.09,
                letterSpacing: 0.10,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomNotificationTile(
              title: S.of(context).GeneralNotification,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomNotificationTile(
              title: S.of(context).Sound,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomNotificationTile(
              title: S.of(context).Vibrate,
            ),
            const SizedBox(
              height: 26,
            ),
            Container(
              width: double.infinity,
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFFEEEEEE),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              S.of(context).Systemservicesupdate,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 0.09,
                letterSpacing: 0.10,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            CustomNotificationTile(
              title: S.of(context).Appupdates,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomNotificationTile(
              title: S.of(context).BillReminder,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomNotificationTile(
              title: S.of(context).Promotion,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomNotificationTile(
              title: S.of(context).DiscountAvaiable,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomNotificationTile(
              title: S.of(context).PaymentRequest,
            ),
            const SizedBox(
              height: 26,
            ),
            Container(
              width: double.infinity,
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFFEEEEEE),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              S.of(context).Others,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 0.09,
                letterSpacing: 0.10,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            CustomNotificationTile(
              title: S.of(context).NewServiceAvailable,
            ),
            const SizedBox(
              height: 16,
            ),
            CustomNotificationTile(
              title: S.of(context).NewTipsAvailable,
            ),
          ],
        ),
      ),
    );
  }
}
