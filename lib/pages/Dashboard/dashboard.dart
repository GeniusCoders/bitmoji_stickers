import 'package:BitmojiStickers/bloc/sticker_bloc/sticker_bloc_bloc.dart';
import 'package:BitmojiStickers/injection.dart';
import 'package:BitmojiStickers/models/dynamic_data/bitmoji_id.dart';
import 'package:BitmojiStickers/pages/loading/loading.dart';
import 'package:BitmojiStickers/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dashboard_widgets/bitmoji_cat_card.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StickerBloc>(context).add(GetBitmojiId());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StickerBloc, StickerState>(
      listener: (context, state) {
        if (state is BitmojiId) {
          getIt<BitmojiIdData>().addBitmojiId(id: state.id);
        }
      },
      builder: (context, state) => SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    padding: EdgeInsets.all(16.w),
                    width: double.infinity,
                    child: Wrap(
                        alignment: WrapAlignment.center,
                        children: list
                            .map((e) => BitmojiCatCard(
                                  title: e['title'],
                                  urlid: e['cat_id'],
                                  backgroundColor: e['color'],
                                  pathName: e['pathName'],
                                ))
                            .toList())),
                Container(
                  child: state is LoadingState ? Loading() : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> list = [
  {
    "cat_id": "10219680",
    "title": "HI",
    "color": blue,
    "pathName": 'hi_stickers_data'
  },
  {
    "cat_id": "e74b9f2f-be55-40a7-9df5-87ba61910d68",
    "title": "Love U",
    "color": pink,
    "pathName": 'love_u_stickers_data'
  },
  {
    "cat_id": "10226887",
    "title": "Lol",
    "color": green,
    "pathName": 'lol_stickers_data'
  },
  {
    "cat_id": "29dbedd6-b9b0-4dbe-a7e3-83bed1b44502",
    "title": "Yes",
    "color": green,
    "pathName": 'yes_stickers_data'
  },
  {
    "cat_id": "ebc0b6a2-146a-4f39-9283-1704639cd4c7",
    "title": "Sad",
    "color": purple,
    "pathName": 'sad_stickers_data'
  },
  {
    "cat_id": "6fbe273c-e60a-4cb1-88bb-7bd645d40b97",
    "title": "Thank You",
    "color": lightGreen,
    "pathName": 'thank_you_stickers_data'
  },
  {
    "cat_id": "7673c023-6a1c-4ead-a0d7-4fa27059e754",
    "title": "Birthday",
    "color": lightGreen,
    "pathName": 'birthday_stickers_data'
  },
  {
    "cat_id": "7ff91094-e4e4-496a-9975-c0b5f6ef26ef",
    "title": "No",
    "color": purple,
    "pathName": 'no_stickers_data'
  },
  {
    "cat_id": "ed5c9c0f-c444-4b15-b96b-a66885184e6a",
    "title": "Compliments",
    "color": green,
    "pathName": 'compliments_stickers_data'
  },
  {
    "cat_id": "e0fdbbb4-0188-49f9-9a25-3102a827ad12",
    "title": "Miss you",
    "color": pink,
    "pathName": 'miss_you_stickers_data'
  },
  {
    "cat_id": "8f42bf78-97e6-4e35-8ec5-709ed099f8e9",
    "title": "Emoji",
    "color": yellow,
    "pathName": 'emoji_stickers_data'
  },
  {
    "cat_id": "b3381b64-4717-4e0a-8999-e73f02cd4693",
    "title": "Good Morning",
    "color": blue,
    "pathName": 'good_morning_stickers_data'
  },
  {
    "cat_id": "20047175",
    "title": "Good Night",
    "color": darkBlue,
    "pathName": 'good_night_stickers_data'
  },
  {
    "cat_id": "27c34645-4e03-42a5-bb21-c48c76fcacfe",
    "title": "Sorry",
    "color": purple,
    "pathName": 'sorry_stickers_data'
  },
  {
    "cat_id": "10217043",
    "title": "Buzzoff",
    "color": purple,
    "pathName": 'buzzoff'
  },
  {
    "cat_id": "20022690",
    "title": "Food",
    "color": green,
    "pathName": 'food',
  },
  {"cat_id": "10222032", "title": "Mad", "color": purple, "pathName": 'mad'},
  {
    "cat_id": "9946988",
    "title": "Question",
    "color": blue,
    "pathName": 'question'
  },
  {"cat_id": "10234040", "title": "Swag", "color": green, "pathName": 'swag'},
  {
    "cat_id": "10039921",
    "title": "Travel",
    "color": lightGreen,
    "pathName": 'travel'
  },
  {"cat_id": "20006618", "title": "Wow", "color": purple, "pathName": 'wow'},
  // {"cat_id": "20007228", "title": "Yay", "color": green, "pathName": 'yay'},
];
