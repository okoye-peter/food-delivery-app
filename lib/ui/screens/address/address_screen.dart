import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yummy/ui/core/themes/app_colors.dart';

class AddressScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final searchController = TextEditingController();
  final spacer = const SizedBox(height: 20);

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar adds the back button to the home screen
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.chevron_left,
            size: 28,
            color: context.colors.inputText,
          ),
        ),
        title: Text(
          'Address',
          style: GoogleFonts.inter(
            color: context.colors.inputText,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.map_outlined,
              size: 24,
              color: context.colors.inputText,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // search
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: searchController,
                textInputAction: TextInputAction.search,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: context.colors.inputText,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: context.colors.searchIcon,
                    size: 20,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 44,
                    minHeight: 52,
                  ),
                  hintText: 'Search food, restaurant,...',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 14,
                    color: context.colors.searchHint,
                  ),
                  filled: true,
                  fillColor: context.colors.searchFill,
                  isDense: true,
                  // fillColor: context.colors.searchFill,
                  iconColor: context.colors.inputText,
                  contentPadding: const EdgeInsets.all(3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            spacer,

            ListTile(
              leading: SvgPicture.asset(
                'assets/svg/dashboard/location.svg',
                width: 24,
              ),
              title: Text(
                '92 Hang Trong',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: context.colors.sectionTitle,
                ),
              ),
              subtitle: Text(
                '92 Hang Trong, Hoan Kiem, Ha Noi',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: context.colors.sectionSubtitle,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: context.colors.sectionSubtitle,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Divider(color: context.colors.inputBorder),
            ),

            ListTile(
              leading: Icon(
                Icons.home_outlined,
                color: context.colors.inputText,
              ),
              title: Text(
                'Floral JSC',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: context.colors.sectionTitle,
                ),
              ),
              subtitle: Text(
                '33B, Pham Ngu Lao, Phan Chu Trinh, Viet Nam',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: context.colors.sectionSubtitle,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: context.colors.sectionSubtitle,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Divider(color: context.colors.inputBorder),
            ),
            ListTile(
              leading: Icon(
                Icons.business_center_outlined,
                color: context.colors.inputText,
              ),
              title: Text(
                'Company CDC VietNam',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: context.colors.sectionTitle,
                ),
              ),
              subtitle: Text(
                '6 Pham Ngu Lao, Phan Chu Trinh, Viet Nam',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: context.colors.sectionSubtitle,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: context.colors.sectionSubtitle,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 3),
              child: Divider(color: context.colors.inputBorder),
            ),

            // SvgPicture.asset('assets/svg/dashboard/location.svg', width: 28),
            // const SizedBox(width: 10,),
            // Column(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     Text('92 Hang Trong', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: context.colors.sectionTitle),)
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
