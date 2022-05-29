import 'package:video_browsing_ui/models/comment.dart';

import 'models/sport.dart';
import 'models/user.dart';
import 'models/video.dart';

abstract class PersistentData {
  static User user(String id) => users.firstWhere((user) => user.id == id);
  static Video video(String id) => videos.firstWhere((video) => video.id == id);

  static final myUser = User(
    id: 'user6',
    name: 'BlindSide',
  );

  static final List<User> users = [
    User(
      id: 'user1',
      name: 'Handball Always',
      hasPhoto: true,
    ),
    User(
      id: 'user2',
      name: 'Alexandre Galambas',
    ),
    User(
      id: 'user3',
      name: 'John',
    ),
    User(
      id: 'user4',
      name: 'Fred',
    ),
    User(
      id: 'user5',
      name: 'Sara',
    ),
    myUser,
  ];

  static final List<Video> videos = List.generate(
    10,
    (i) => Video(
        id: 'video$i',
        title:
            'Training for improvement of agility, speed, jumping and shooting ability in handball players',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum efficitur lacinia semper. Suspendisse gravida sapien nibh, at vehicula lacus luctus accumsan. Pellentesque fringilla lorem orci, eu pulvinar metus tristique sed. Suspendisse eget arcu fringilla diam tristique convallis quis id lacus. Proin tincidunt dolor vel lorem sodales, vel consectetur dui fermentum. Proin sit amet malesuada leo, in sagittis lorem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse potenti. Aliquam convallis elit id enim rutrum aliquet. Nam nec risus pellentesque, tempus neque at, tincidunt eros. Ut feugiat diam tristique, tempor est non, euismod erat. Praesent nibh lectus, vehicula a lacus vitae, aliquam pharetra enim. Morbi ac felis ut tellus finibus aliquet. Donec eleifend fringilla erat, a vestibulum felis elementum ac. Nullam in augue eget orci cursus rhoncus et et lacus. Vivamus fermentum diam eu aliquam tincidunt.',
        tags: [
          'handball',
          'training',
          'agility',
          'speed',
          'jumping',
          'shooting'
        ],
        sport: Sport.handball,
        creatorId: 'user1',
        postDate: DateTime(2020, 05, 08, 17, 44),
        comments: [
          Comment(
            text:
                'After watching this video I feel like I can do much better in my training, thanks!',
            userId: 'user2',
            time: DateTime(2020, 05, 08, 18, 01),
          ),
          Comment(
            text: 'Great video!!',
            userId: 'user2',
            time: DateTime(2020, 05, 08, 19, 40),
          ),
          Comment(
            text: 'I wish you could be my coach...',
            userId: 'user3',
            time: DateTime(2020, 05, 09, 09, 32),
          ),
          Comment(
            text: 'Another great video, keep it up',
            userId: 'user4',
            time: DateTime(2020, 05, 10, 01, 00),
          ),
        ]),
  );
}
