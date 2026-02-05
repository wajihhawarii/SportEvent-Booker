import 'package:ci_projecct/core/shared/widgets/custom_circule.dart';
import 'package:ci_projecct/core/utils/app_colors.dart';
import 'package:ci_projecct/core/utils/app_text.dart';
import 'package:ci_projecct/core/utils/routing/extentations.dart';
import 'package:ci_projecct/core/utils/routing/routes.dart';
import 'package:ci_projecct/features/events/presentation/pages/drawer_home.dart';
import 'package:ci_projecct/features/events/presentation/widgets/custom_down_widget.dart';
import 'package:ci_projecct/features/events/presentation/widgets/error_widget.dart';
import 'package:ci_projecct/features/events/presentation/widgets/search_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/event_cubit.dart';
import '../cubit/event_state.dart';
import '../widgets/event_card.dart';
import '../widgets/filter_chips.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late EventCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = context.read<EventCubit>();
    cubit.loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      AppText.all,
      AppText.footBall,
      AppText.basketBall,
      AppText.tennis,
    ];
    return Scaffold(
      backgroundColor: AppColors.grey100,
      drawer: buildDrawer(context),
      appBar: AppBar(
        title: const Text(
          AppText.sportEvents,
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.blue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Search Filed
              SearchField(),
              SizedBox(height: 12.h),
              //category card list
              BlocSelector<EventCubit, EventState, String>(
                selector:
                    (state) =>
                        state is EventLoaded
                            ? state.selectedCategory
                            : AppText.all,
                builder: (context, selectedCategory) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: FilterChips(
                      categories: categories,
                      selectedCategory: selectedCategory,
                      onSelected:
                          (category) => cubit.updateSelectedCategory(category),
                    ),
                  );
                },
              ),
              SizedBox(height: 8.h),
              // events card list
              Expanded(
                child: BlocBuilder<EventCubit, EventState>(
                  builder: (context, state) {
                    if (state is EventLoading) {
                      return const Center(child: CustomCircule());
                    } else if (state is EventError) {
                      return CustomErrorWidget(text: state.message);
                    } else if (state is EventLoaded) {
                      final events = state.filteredEvents;
                      if (events.isEmpty) {
                        return const Center(child: Text(AppText.noEventsFound));
                      }
                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<EventCubit>().loadEvents();
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          itemCount: events.length,
                          itemBuilder: (context, index) {
                            final event = events[index];
                            return Stack(
                              children: [
                                EventCard(
                                  event: event,
                                  onTap: () {
                                    context.pushNamed(
                                      Routes.eventDetailesPage,
                                      arguments: {
                                        'event': event,
                                        'cubit': context.read<EventCubit>(),
                                      },
                                    );
                                  },
                                ),
                                Positioned(
                                  right: 50.h,
                                  bottom: 20.h,
                                  child: CountdownWidget(startTime: event.date),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
