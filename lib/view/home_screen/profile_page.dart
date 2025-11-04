import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/profile_list_item.dart';
import '../../core/theme/colors.dart';
import '../../cubit/auth_cubit/auth_cubit.dart';
import '../../data/models/profile_list_tile_model.dart';
import '../../router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  List<ProfileListTileModel> items = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    print('Profile initState');
    super.initState();
    items = [
      ProfileListTileModel(
        title: 'Personal information',
        description: 'Email, Password, Phone number...',
        imageUrl: 'profile.svg',
        onPressed: () {},
      ),
      ProfileListTileModel(
        title: 'Settings',
        description: 'Companies Location, Notifications...',
        imageUrl: 'setting.svg',
        onPressed: () {},
      ),
      ProfileListTileModel(
        title: 'About',
        description: 'Privacy policy, Third party...',
        imageUrl: 'about.svg',
        onPressed: () {},
      ),
      ProfileListTileModel(
        title: 'Logout',
        imageUrl: 'logout.svg',
        imageBackgroundColor: const Color(0x291E1E29),
        onPressed: () async {
          await context.read<AuthCubit>().signOut();
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignOutSuccessState) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRouter.auth, (route) => false);
        } else if (state is SignOutFailState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is SignOutLoadingState || state is SignOutSuccessState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 54, right: 16, left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: AppColors.white,
                          ),
                    ),
                    const SizedBox(height: 32),
                    buildUserDateRow(context),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: items.length,
                    padding:
                        const EdgeInsets.only(top: 32, right: 16, left: 16),
                    itemBuilder: (BuildContext context, int index) {
                      return ProfileListItem(listItem: items[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildUserDateRow(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 88,
          height: 88,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.16),
            shape: BoxShape.circle,
            border: Border.all(
              width: 2,
              color: AppColors.white,
            ),
          ),
          child: Text(
            'A',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 48,
                  color: AppColors.white,
                ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ahmad Djamal',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: AppColors.white,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Joined november 2022',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: AppColors.white.withOpacity(0.56),
                  ),
            ),
            const SizedBox(height: 4),
            if (!FirebaseAuth.instance.currentUser!
                .emailVerified) // TODO: Null check operator used on a null value
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.white.withOpacity(0.16),
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Verify your email',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: AppColors.white,
                      ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
